% Determine the Allan Variance from recorded frequency data

%This time, pick a tau step and a tau limit and break the large buffer
%into intervals of tau size
% Perform frequency estimation on those intervals and compute overall
% allan variance
% Don't do windowing here

% for measurements and tracking simulations, the obtained q parameters will
% be twice as large since we are measuring/simulating the diference of two
% oscillators. 
% Known Parameters:
% fs - sampling frequency
% largebuffer - the buffer with data recorded at fs

%clear;
%clc;
%load('recording2.mat');
%L = 3650000; %= length(largebuffer); % number of frequency estimations

% % generate white noise + wiener process synthetic frequency offsets
% q12 = [(5*10^-11)^2 (10^-16)^2];
% deltat = 1;%0.0001;
% q1 = q12(1); % variance of the white noise part
% q2 = q12(2); % variance of wiener process (q2*deltat)
% w2 = zeros(1,2*10^7);
% y  = zeros(1,2*10^7);
% w2(1) = 0;
% for n = 2:2*10^5
%     if (mod(n,10000)==0)
%         n
%     end
%     w2(n) = w2(n-1)+randn(1);
%     eps1 = sqrt(q1)*randn(1);
%     y(n) = w2(n);
% end
% figure; plot(y)


Lf = 500000;
fc = 900e6; %nominal carrier frequency (900MHz)
j = 1;
fdiff=[];
x= diff(DELnm(1,:))*fs;%DELnm(2,:);%y(1:100000);%freq_vec(1:4542);

    for n = 10:10000%2000:0.5*10^7
        fdiff=[];
        n;
         for k=1
            j=1;
            while (j*n+k-1<=Lf)
                %favg(j)=mean(x(n*(j-1)+1:n*j));
                favg(j)=mean(x(k+n*(j-1):k+n*j-1));
                j=j+1;
            end
            j 
            %fdiff = [fdiff diff(favg(1:j-1))];
         end
          Allanv(n) = 0.5*mean(diff(favg(1:j-1)).^2);
        % Allanv(n) = 0.5*mean(fdiff.^2);
    end
tstep=0.001;
timevec=tstep*(10:n);
figure
plot(x)
figure 
loglog(timevec,Allanv(10:n));
xlabel('Tau (sec)')
ylabel('{\sigma_v}^2');

xdata = timevec;%(1:110);%tau;
ydata = Allanv(10:n);%(10:119);%sigma;

A = [1./xdata; xdata./3]'; %create the A vector for parameters

q12 = (inv(A'*A)*A'*(ydata)')./2; % compute the least squares matrix fit

%  
%  dfit = polyfitn(timevec(1:13),Allanv(10:22),'constant, x^-1');
%      q1est = dfit.Coefficients(2)
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
    