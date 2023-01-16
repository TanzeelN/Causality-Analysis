clear
clc

time = {};
for i = 1:1
    time(i) = {0:0.001:4.999};
end

for i = 1:20
    RandomNumberSet1 = normrnd(0,1,1,5000);
    RandomNumberSet2 = normrnd(0,1,1,5000);

    x = RandomNumberSet1;
    y = 0.5*x + 0.5*RandomNumberSet2;
    z = 0.5*x + 0.5*y;

    trial = {[x; y; z]};
   
%     trial(1,:) = [x];
%     trial(2,:) = [y];
%     trial(3,:) = [z];

    data.trial(1,i) = trial;
    data.time(1,i) = time;
end


label = [{'A1'} {'A2'} {'A3'}];
data.label = label;
data.fsample = 1000;




save('3variablesystem','data');