% Determine the Allan Variance from recorded frequency data

%This time, pick a tau step and a tau limit and break the large buffer
%into intervals of tau size
% Perform frequency estimation on those intervals and compute overall
% variance


% Known Parameters:
% fs - sampling frequency
% largebuffer - the buffer with data recorded at fs

%clear;
%clc;
%load('recording2.mat');
%L = 3650000; %= length(largebuffer); % number of frequency estimations

Lf = 5860;
fc = 900e6; %nominal carrier frequency (900MHz)
j = 1;
fdiff=[];
x=freq_vec_sim; %randn(1,4542);

tstep=0.512;

timevec=tstep*(0:n-1);

for n = 2:Lf/5
    fdiff = [];
    for k = 1:n
        x_temp = x(k:end);
        L = length(x_temp);
        Lnew = floor(L/n)*n;
        m = Lnew/n;
        favg = mean(reshape(x_temp(1:Lnew),n,m));
        fdiff = [fdiff diff(favg)];
    end
    plot(fdiff);
    pause(0.001);
    Allanv(n) = var(fdiff/fc);
end

timevec=tstep*(0:n-1);

 figure
 semilogx(timevec(1:n-1),Allanv(1:n-1));
 xlabel('Tau (sec)')
 ylabel('{\sigma_v}^2');
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
    