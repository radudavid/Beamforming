
%getData;

def_q = zeros(4, 2);
noext_q = zeros(4, 2);
ext_q = zeros(4, 2);

[def_q(1,1), def_q(1,2)] = getQs(data, 200e3, 900e6, 50, 50000);
% [def_q(2,1), def_q(2,2)] = getQs(def2, Fs, 900e6, 50, 50000);
% [def_q(3,1), def_q(3,2)] = getQs(def3, Fs, 900e6, 50, 50000);
% [def_q(4,1), def_q(4,2)] = getQs(def4, Fs, 900e6, 50, 50000);
% 
% [noext_q(1,1), noext_q(1,2)] = getQs(noext1, Fs, 900e6, 50, 50000);
% [noext_q(2,1), noext_q(2,2)] = getQs(noext2, Fs, 900e6, 50, 50000);
% [noext_q(3,1), noext_q(3,2)] = getQs(noext3, Fs, 900e6, 50, 50000);
% [noext_q(4,1), noext_q(4,2)] = getQs(noext4, Fs, 900e6, 50, 50000);
% 
% [ext_q(1,1),ext_q(1,2)] = getQs(ext1, Fs, 900e6, 50, 50000);
% [ext_q(2,1),ext_q(2,2)] = getQs(ext2, Fs, 900e6, 50, 50000);
% [ext_q(3,1),ext_q(3,2)] = getQs(ext3, Fs, 900e6, 50, 50000);
% [ext_q(4,1),ext_q(4,2)] = getQs(ext4, Fs, 900e6, 50, 50000);