clear
clc

time = {};
for i = 1:1
    time(i) = {0:0.001:4.999};
end

for i = 1:20
    RandomNumberSet1 = normrnd(5,1,1,5000);
    RandomNumberSet2 = normrnd(1,1,1,5000);

    y = RandomNumberSet1;
    x = (y.^2)/4;
    z = sqrt(x) + 0.5*RandomNumberSet2;
    w = x + 0.5*z;
    trial = {[x; y; z; w]};
   
%     trial(1,:) = [x];
%     trial(2,:) = [y];
%     trial(3,:) = [z];

    data.trial(1,i) = trial;
    data.time(1,i) = time;
end


label = [{'A1'} {'A2'} {'A3'} {'A4'}];
data.label = label;
data.fsample = 1000;




save('3variablesystem','data');