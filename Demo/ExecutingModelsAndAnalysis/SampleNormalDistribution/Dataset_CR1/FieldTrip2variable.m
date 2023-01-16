clear
clc

time = {};
for i = 1:1
    time(i) = {0:0.001:0.999};
end

for i = 1:5
    RandomNumberSet1 = normrnd(5,1,1,1020);
    x = RandomNumberSet1;
    y = 0.5*x.^2+0.5*(normrnd(0,1,1,1020));
    z = 0.5*x + 0.5*y.^2;
    trial = {[x(1:1000); y(1:1000); z(1:1000)]};
   
%     trial(1,:) = [x];
%     trial(2,:) = [y];
%     trial(3,:) = [z];

    data.trial(1,i) = trial;
    data.time(1,i) = time;
end


label = [{'A1'} {'A2'} {'A3'}];
data.label = label;
data.fsample =1000;




save('FieldTripDataset_CR1.mat','data');