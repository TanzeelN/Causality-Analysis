clear
clc

time = {};
for i = 1:1
    time(i) = {0:0.001:4.999};
end

for i = 1:20
    timevariable = 0:0.005:24.999;
    x = sin(timevariable);
    y = sin(timevariable);
    z = sin(timevariable);
    trial = {[x; y; z]};
   
    data.trial(1,i) = trial;
    data.time(1,i) = time;
end


label = [{'A1'} {'A2'} {'A3'}];
data.label = label;
data.fsample = 1000;




save('FieldTripDataset_Sin.mat','data');