hSDRu = comm.SDRuTransmitter(...
    'IPAddress', '192.168.10.11', ...
    'CenterFrequency', 900.0e6-44e3, ...
    'InterpolationFactor', 512);
hMod = comm.GeneralQAMModulator();
hMod.Constellation = [1 1i -1];
 %data = randi([0 1], 30, 1);
data_t = ones(5000,1);
modSignal = step(hMod, data_t);
while 1
    step(hSDRu, modSignal);
end