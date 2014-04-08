% Determine the Allan Variance from recorded frequency data

%This time, pick a tau step and a tau limit and break the large buffer
%into intervals of tau size
% Perform frequency estimation on those intervals and compute overall
% variance


% Known Parameters:
% fs - sampling frequency
% largebuffer - the buffer with data recorded at fs

L = 3650000; %= length(largebuffer); % number of frequency estimations

fc = 900e6; %nominal carrier frequency (900MHz)
j = 1;
for n = 1000:1000:L/100
    i=1;
    while i*n<L
        data=largebuffer(n*(i-1)+1:n*i);
        N=length(data);
        %% Compute frequency of the blok. this section should be a function
        t=DS*Ts*(1:N);
        
        % length of the signal x
        
        % define a time vector
        ssf=(-N/2:N/2-1)/(DS*Ts*N);                   % frequency vector
        
        fx=fft(data);                            % do DFT/FFT
        fxs=fftshift(fx);                          % shift it for plotting
                
        c = find(abs(fxs)==max((abs(fxs))));
        cf = ssf(c);
        % fft_freq(i)=cf;
        v = abs(fxs(c-2:c+2))'; % select 5 points around the maximum fft frequency
        y = ssf(c-2:c+2);
        p = polyfit(y,v,2); % fit a second order polinimial to the data
        bestf = -p(2)/(2*p(1)); % compute the best frequency
        freq(i)=bestf;
        i=i+1;
    end
    
    Allan(j)=var(diff(freq/fc));
    j=j+1
end
% freq_vec=freq_vec(1:L);
% 
% phi=zeros(L,1);
% phidot=freq_vec;
% 
% 
% u2=diff(freq_vec);
% 
% 
% for i=2:L
%     phi(i) = phi(i-1)+T*phidot(i-1);
% end
% 
% p_var=var(phi);
% 
% 
% for ind=1:20
%     tau(ind)=T*ind;
%     phidot=freq_vec(1:ind:end);
%     sig_tau(ind)=var(phidot);
% end
% 
% plot(T*ind,sig_tau)
    