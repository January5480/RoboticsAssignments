% LPC求根法的共振峰估计
clear all; clc; close all;

fle='C4_3_y.wav';                            % 指定文件名
[xx,fs]=audioread(fle);                       % 读入一帧语音信号
u=filter([1 -.99],1,xx);                    % 预加重
wlen=length(u);                             % 帧长
p=4;                                       % LPC阶数
n_frmnt=1;                                  % 取四个共振峰
freq=(0:256)*fs/512;                        % 频率刻度
df=fs/512;                                  % 频率分辨率

[F,Bw,U]=Formant_Root(u,p,fs,n_frmnt);
plot(freq,U,'k');
title('声道传递函数功率谱曲线');
xlabel('频率/Hz'); ylabel('幅值/dB');
p1=length(F);                              % 在共振峰处画线
m=ceil(F/df);
pp=U(m);                                    %共振峰幅度
for k=1 : p1
    line([F(k) F(k)],[-10 pp(k)],'color','k','linestyle','-.');
end
legend('功率谱','共振峰位置')
fprintf('F0=%5.2f   %5.2f   %5.2f   %5.2f\n',F);
fprintf('Bw=%5.2f   %5.2f   %5.2f   %5.2f\n',Bw);

gtext(['LPC阶数', num2str(p)], 'Color', 'g','FontSize', 14,'FontWeight', 'bold')
gtext(['共振峰个数', num2str(n_frmnt)], 'Color', 'g','FontSize', 14,'FontWeight', 'bold')
gtext('共振峰频率', 'Color', 'b','FontSize', 14,'FontWeight', 'bold')

for k = 1 : length(F)
    gtext(num2str(round(F(k))), 'Color', 'b','FontSize', 14,'FontWeight', 'bold')
end
gtext('共振峰带宽', 'Color', 'r','FontSize', 14,'FontWeight', 'bold')
for k = 1 : length(Bw)
    gtext(num2str(round(Bw(k))), 'Color', 'r','FontSize', 14,'FontWeight', 'bold')
end

