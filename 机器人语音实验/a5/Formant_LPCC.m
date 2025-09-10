function [Frmt, Bw, U] = Formant_LPCC(x_frame, p, fs, num_formants)
    [a, ~] = lpc(x_frame, p);    
    % 计算LPC倒谱
    cep = real(ifft(log(abs(fft(a, 512)))));    
    % 平滑倒谱（保留低阶倒谱系数，丢弃高阶）
    cep_smooth = zeros(size(cep));
    max_cep_order = min(12, length(cep)/2);  % 通常保留前12个倒谱系数
    cep_smooth(1:max_cep_order) = cep(1:max_cep_order);    
    % 恢复平滑后的频谱
    spec_smooth = abs(fft(cep_smooth, 512));    
    % 寻找峰值（共振峰）
    [pks, locs] = findpeaks(spec_smooth, 'SortStr', 'descend');    
    % 转换为频率（Hz）
    freq = (locs-1) * fs / 512;    
    % 选择前num_formants个共振峰
    if length(freq) >= num_formants
        Frmt = freq(1:num_formants);        
        % 简单计算带宽（这里使用简化方法，实际应用中可能需要更复杂的算法）
        Bw = zeros(num_formants, 1);
        for i = 1:num_formants
            idx = locs(i);
            % 找到峰值两侧-3dB点
            left_idx = idx;
            while left_idx > 1 && spec_smooth(left_idx) > pks(i)/sqrt(2)
                left_idx = left_idx - 1;
            end
            right_idx = idx;
            while right_idx < length(spec_smooth) && spec_smooth(right_idx) > pks(i)/sqrt(2)
                right_idx = right_idx + 1;
            end
            Bw(i) = (right_idx - left_idx) * fs / 512;
        end
    else
        % 如果找到的峰值不足，用0填充
        % 修正：确保freq是列向量
        if ~iscolumn(freq)
            freq = freq';
        end
        % 使用zeros生成与freq相同方向的向量
        Frmt = [freq; zeros(num_formants-length(freq), 1)];
        Bw = zeros(num_formants, 1);
    end    
    U = ones(num_formants, 1) * 0.5;  % 不确定度（示例值）
end