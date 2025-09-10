function [Frmt, Bw, U] = Formant_Cepstrum(x_frame, p, fs, num_formants)
    % 使用倒谱法提取共振峰
    % 输入:
    %   x_frame: 一帧语音信号
    %   p: LPC阶数（用于谱估计）
    %   fs: 采样率
    %   num_formants: 需要提取的共振峰数量
    % 输出:
    %   Frmt: 共振峰频率（列向量）
    %   Bw: 共振峰带宽（列向量）
    %   U: 不确定度（列向量）
    
    % 加窗
    win = hamming(length(x_frame));
    x_win = x_frame .* win;
    
    % 计算频谱（使用LPC或直接FFT）
    use_lpc = true;  % 是否使用LPC谱代替直接FFT谱
    
    if use_lpc
        % 使用LPC谱估计
        [a, ~] = lpc(x_win, p);
        n_fft = 2048;
        H = 1./abs(fft(a, n_fft));
        log_mag = 20 * log10(H);  % 转换为dB
    else
        % 使用直接FFT谱
        n_fft = 2048;
        X = fft(x_win, n_fft);
        log_mag = 20 * log10(abs(X));  % 转换为dB
    end
    
    log_mag = log_mag(1:n_fft/2+1);  % 保留正频率部分
    freq = (0:n_fft/2) * fs / n_fft;
    
    % 计算倒谱（cepstrum）
    cepstrum = real(ifft(log_mag));
    
    % 确定倒谱窗（用于分离包络）
    max_cep_order = round(fs/500);  % 通常取500Hz以上的倒谱系数
    min_cep_order = 2;  % 避免直流分量
    
    % 创建倒谱窗
    cep_win = zeros(size(cepstrum));
    cep_win(min_cep_order:max_cep_order) = 1;
    
    % 应用窗函数提取包络
    smoothed_cep = cepstrum .* cep_win;
    
    % 恢复平滑后的频谱包络
    smoothed_log_mag = fft(smoothed_cep);
    smoothed_log_mag = smoothed_log_mag(1:n_fft/2+1);
    
    % 寻找包络中的峰值（共振峰）
    [pks, locs] = findpeaks(real(smoothed_log_mag), 'SortStr', 'descend');
    
    % 转换为频率
    formant_freqs = freq(locs);
    
    % 确保结果为列向量
    formant_freqs = formant_freqs(:);
    
    % 选择前num_formants个共振峰
    detected_count = length(formant_freqs);
    Frmt = zeros(num_formants, 1);
    Bw = zeros(num_formants, 1);
    U = zeros(num_formants, 1);
    
    if detected_count >= 1
        % 只处理检测到至少一个共振峰的情况
        % 选择前num_formants个共振峰
        select_count = min(detected_count, num_formants);
        Frmt(1:select_count) = formant_freqs(1:select_count);
        
        % 计算带宽（从平滑频谱包络中测量）
        for i = 1:select_count
            idx = locs(i);
            peak_val = pks(i);
            target_val = peak_val - 3;  % -3dB
            
            % 寻找左侧-3dB点
            left_idx = idx;
            while left_idx > 1 && real(smoothed_log_mag(left_idx)) > target_val
                left_idx = left_idx - 1;
            end
            
            % 寻找右侧-3dB点
            right_idx = idx;
            while right_idx < length(smoothed_log_mag) && real(smoothed_log_mag(right_idx)) > target_val
                right_idx = right_idx + 1;
            end
            
            % 计算带宽（Hz）
            Bw(i) = (right_idx - left_idx) * fs / n_fft;
        end
        
        % 计算不确定度（基于峰值高度与平均高度的比值）
        avg_peak = mean(pks(1:select_count));
        U(1:select_count) = 1 - min(pks(1:select_count)/max(pks(1:select_count)), 1);
    end
    
    % 移除不可能的共振峰（例如超过Nyquist频率或低于100Hz）
    invalid_idx = Frmt < 100 | Frmt > fs/2;
    Frmt(invalid_idx) = 0;
    Bw(invalid_idx) = 0;
    U(invalid_idx) = 1;  % 高不确定度
    
    % 确保输出为列向量
    Frmt = Frmt(:);
    Bw = Bw(:);
    U = U(:);
end