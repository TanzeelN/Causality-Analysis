clear
clc

time = {};
for i = 1:1
    time(i) = {0:0.001:4.999};
end

for i = 1:20
    x_noise = 0.1*normrnd(0,1,[1,5000]);
    y_noise = 0.1*normrnd(0,1,[1,5000]);
    z_noise = 0.1*normrnd(0,1,[1,5000]);
    timevariable = 0:0.005:24.999;
    x = sin(timevariable)+x_noise;
    y = sin(timevariable)+y_noise;
    z = sin(timevariable)+z_noise;
    trial = {[x; y; z]};
   
    data.trial(1,i) = trial;
    data.time(1,i) = time;
end


label = [{'A1'} {'A2'} {'A3'}];
data.label = label;
data.fsample = 1000;
save("FieldTripDataset_Sinus+Noise.mat",'data','-mat')