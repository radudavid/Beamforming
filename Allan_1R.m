% Determine the Allan Variance from recorded frequency data

T = N/fs; % frequency estimation period
L = length(largebuffer)/N; % number of frequency estimations

freq_vec=freq_vec(1:L);

phi=zeros(L,1);
phidot=freq_vec;


u2=diff(freq_vec);


for i=2:L
    phi(i) = phi(i-1)+T*phidot(i-1);
end

p_var=var(phi);


for ind=1:20
    tau(ind)=T*ind;
    phidot=freq_vec(1:ind:end);
    sig_tau(ind)=var(phidot);
end

plot(T*ind,sig_tau)
    