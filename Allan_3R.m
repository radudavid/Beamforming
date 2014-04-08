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

Lf = 39063;
fc = 900e6; %nominal carrier frequency (900MHz)
j = 1;
fdiff=[];
x= DELnm(2,:);%freq_vec_sim; %randn(1,4542);
for iteration = 1%:7
    %x = f_mat(:,iteration);
    for n = 1:4000
        fdiff=[];
        n;
        for k=1%:n
            j=1;
            while (j*n+k-1<=Lf)
                favg(j)=mean(x(k+n*(j-1):k+n*j-1));
                j=j+1;
            end
            j
            fdiff=[fdiff diff(favg(1:j-1))];
           
            %     f_diff = [f_diff diff(freq_vec3(k:n:Lf))];
        end
         plot(fdiff)
            pause(0.01)
        Allanv(iteration,n) = var(fdiff/fc);
    end
end
tstep=0.512;

timevec=tstep*(0:n-1);

 figure
 semilogx(timevec,Allanv(1,:));
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
    