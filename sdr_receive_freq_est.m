%USRP Frequency Estimation Project
%Radu David
%March 2014
fs = 100e6/512; % sampling frequency as fraction of 100MHz
Ts = 1/fs; % sampling period
FrameLength=1e4;
DS = 1; %downsample decimator

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Commands to set the USRP on external oscillator (this turns off
% Oscillator Compensation)
% h = UsrpMaskMapiT('192.168.10.12', BoardIdCapiEnumT.MboardId)
 
% h.setClockConfig(CannedClockConfigCapiEnumT.External);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hSDRu = comm.SDRuReceiver('192.168.10.12', ...
    'CenterFrequency', 900e6, ...
    'DecimationFactor', 512,...
    'OutputDataType','double','Gain',32,'FrameLength',FrameLength);
 hss = dsp.SpectrumAnalyzer('SampleRate', fs);
 
 hLogger = dsp.SignalSink;

 hLogger.reset;

 figure;
 clf;
 plot(0,0);
 hold on
 xlim([0 500]);
 xlabel('Step Number');
 ylabel('Frequency offset (Hz)');
largebuffer=[];
freq_vec = zeros(1,5000);
fphase = zeros(1,5000);
% tic
count=0;
    i = 1;
    tic
for counter = 1:5000000
    data_r = step(hSDRu);
    if sum(data_r) == 0
        continue
    end

   step(hLogger, data_r);
   % toc
   % step(hss,data_r);
   count=count+1;
   if mod(count,10) 
   continue
   end
   
   
   data=downsample(hLogger.Buffer,DS);
    N=length(data);
    t=DS*Ts*(1:N);
 
 % length of the signal x
 
 % define a time vector
    ssf=(-N/2:N/2-1)/(DS*Ts*N);                   % frequency vector

    hLogger.reset;
    fx=fft(data);                            % do DFT/FFT
    fxs=fftshift(fx);                          % shift it for plotting
    largebuffer((i-1)*N+1:i*N)=data;
    
    c = find(abs(fxs)==max((abs(fxs))));
    cf = ssf(c);
    fft_freq(i)=cf;
    v = abs(fxs(c-2:c+2))'; % select 5 points around the maximum fft frequency
    y = ssf(c-2:c+2); 
    p = polyfit(y,v,2); % fit a second order polinimial to the data 
    bestf = -p(2)/(2*p(1)); % compute the best frequency
    freq_vec(i)=bestf;
    phase=unwrap(angle(data));
    fphase(i) = ((phase(end)-phase(1))/(10*FrameLength/fs))/(2*pi);
    if i>2
        plot([i-1 i],[freq_vec(i-1) freq_vec(i)])
        plot([i-1 i],[fphase(i-1) fphase(i)],'--r')
        toc
    end
    pause(0.01)
    i=i+1;
    if (i==7000)
        break;
    end
end
save('RunApril1st.mat','largebuffer','fphase','freq_vec');

% x = (hLogger.Buffer(100000:200000));
% 
% N=length(x);                               % length of the signal x
% t=Ts*(1:N);                                % define a time vector
% ssf=(-N/2:N/2-1)/(Ts*N);                   % frequency vector
% fx=fft(x(1:N));                            % do DFT/FFT
% fxs=fftshift(fx);                          % shift it for plotting
% subplot(2,1,1), plot(t,x)                  % plot the waveform
% xlabel('seconds'); ylabel('amplitude')     % label the axes
% subplot(2,1,2), plot(ssf,20*log10(abs(fxs)))         % plot magnitude spectrum
% xlabel('frequency'); ylabel('magnitude')   % label the axes
