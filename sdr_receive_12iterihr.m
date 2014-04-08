%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Code that uses the USRP to receive a carrier tone
%Detect the phase and frequency for 100000 samples (0.512 seconds)
%compute frequency estimate and phase estimate

fs = 100e6/512; % sampling frequency as fraction of 100MHz
Ts = 1/fs; % sampling period
FrameLength=1e4; % length of a frame received from USRP
DS = 1; %downsample decimator

% h = UsrpMaskMapiT('192.168.10.12', BoardIdCapiEnumT.MboardId)

% h.setClockConfig(CannedClockConfigCapiEnumT.External);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hSDRu = comm.SDRuReceiver('192.168.10.12', ...
    'CenterFrequency', 900e6, ...
    'DecimationFactor', 512,...
    'OutputDataType','double','Gain',32,'FrameLength',FrameLength);
hss = dsp.SpectrumAnalyzer('SampleRate', fs);
hLogger = dsp.SignalSink;
hLogger.reset;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure;
% clf;
% plot(0,0);
% hold on
% xlim([0 4000]);
% xlabel('Step Number');
% ylabel('Frequency offset (Hz)');

L = 6000;
freq_vec=zeros(1,L);
iteration = 1;
count = 0;
i = 1;
tic
p_mat=zeros(L,12);
f_mat=zeros(L,12);
while 1
    data_r = step(hSDRu);
    if sum(data_r) == 0
        continue
    end
    
    step(hLogger, data_r);
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
    
    %largebuffer=[largebuffer; data];
    
    c = find(abs(fxs)==max((abs(fxs))));
    cf = ssf(c);
    fft_freq(i)=cf;
    v = abs(fxs(c-2:c+2))'; % select 5 points around the maximum fft frequency
    y = ssf(c-2:c+2);
    ws = warning('off','all');
    p = polyfit(y,v,2); % fit a second order polinimial to the data
    bestf = -p(2)/(2*p(1)); % compute the best frequency
    freq_vec(i)=bestf;
    
    phase(i)=angle(fxs(c));
    %     if i>2
    %         plot([i-1 i],[freq_vec(i-1) freq_vec(i)])
    %     end
    %     pause(0.01)
    if (i==L)
        i = 1;
        p_mat(:,iteration)=phase;
        f_mat(:,iteration)=freq_vec;
        iteration=iteration+1;
        subplot(2,1,1);
        plot(freq_vec);
        title(['Iteration = ',int2str(iteration)]);
        ylabel('Frequency Offset');
        subplot(2,1,2);
        plot(phase);
        ylabel('Phase');
        pause(0.01);
        [iteration toc]
    end
    i=i+1;
end