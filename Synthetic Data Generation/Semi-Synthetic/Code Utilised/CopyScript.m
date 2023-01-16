%This script was used to generate the TRENTCH_Combs.mat file
pathforfolder = fullfile('Dataset*');

foldername = dir(pathforfolder);

foldersize = size(foldername,1);

for i = 1:foldersize
    cd(foldername(i).name)
    TEComb.config = {'A2' 'A3';'A2' 'A15'; 'A2' 'A16';'A3' 'A2'; 'A3' 'A15';'A3' 'A16';'A15' 'A2'; 'A15' 'A3'; 'A15' 'A16';'A16' 'A2';
        'A16' 'A3'; 'A16' 'A15'};
    save("TRENTCHCombs.mat",'TEComb','-mat')
    cd ..\
end