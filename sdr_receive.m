fs = 100e6/512; %
hSDRu = comm.SDRuReceiver('192.168.10.12', ...
    'CenterFrequency', 900e6, ...
    'DecimationFactor', 512,...
    'OutputDataType','double','Gain',32,'FrameLength',10000);
 hss = dsp.SpectrumAnalyzer('SampleRate', 100e6/512);

hLogger = dsp.SignalSink;
tic
for counter = 1:200000
    data_r = step(hSDRu);
    if sum(data_r) == 0
        continue
    end
    step(hLogger, data_r);
    toc
   % step(hss,data_r);
end

% x = (hLogger.Buffer(100000:200000));
% 
% N=length(x);                               % length of the signal x
% t=Ts*(1:N);                                % define a time vector
% ssf=(-N/2:N/2-1)/(Ts*N);                   % frequency vector
% fx=fft(x(1:N));                            % do DFT/FFT
% fxs=fftshift(fx);     C                     % shift it for plotting
% subplot(2,1,1), plot(t,x)                  % plot the waveform
% xlabel('seconds'); ylabel('amplitude')     % label the axes
% subplot(2,1,2), plot(ssf,20*log10(abs(fxs)))         % plot magnitude spectrum
% xlabel('frequency'); ylabel('magnitude')   % label the axes
