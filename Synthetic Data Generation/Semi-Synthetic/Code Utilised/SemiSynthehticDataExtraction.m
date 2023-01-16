
%Enter Folder with homer processed files
%cd('homerOutput');
%run('C:\Users\Tanzeel\Desktop\MSc Project\Programming\ToolBoxes\Homer3\setpaths.m');

%Remove unwaned folders and append wanted folders to a list
allfiles = dir;
foldernames = {allfiles([allfiles.isdir]).name};
for i = 1:size(foldernames)
    if foldernames(i) == "."
        foldernames(i) = [];
    end
end

for i = 1:size(foldernames)
    if foldernames(i) == ".."
        foldernames(i) = [];
    end
end



%Iterate Through Folders to extract files
foldername_dim = size(foldernames);
foldername_dim = foldername_dim(2);
createdfoldernames = {};
for i = 1:foldername_dim;
    name = sprintf('Dataset%d',i);
    createdfoldernames{i} = name;
    mkdir(name);
   filePattern = fullfile(cell2str(foldernames(i)),'*.mat');
   theFiles = dir(filePattern);
   for j = 1:size(theFiles)
       cd(cell2str(foldernames(i)))
       load(theFiles(j).name)
       filename = theFiles(j).name;
       data = output.dc.dataTimeSeries;
       time = output.dc.time;
       fnirstype = output.dc.measurementList;
       fnirsdata.name = filename;
       fnirsdata.data = data;
       fnirsdata.time = time;
       fnirsdata.fnirstype = output.dc.measurementList;
       cd ..\
       cd(name)
       save(filename,'fnirsdata','-mat')
       cd ..\
   end
end
%% 

%-------------------------------------------------------------------------
%Extract HBO data
createdfoldernames_dim = size(createdfoldernames);
createdfoldernames_dim = createdfoldernames_dim(2);
keepindex = 1:3:102;
for i = 1:createdfoldernames_dim
    filePattern = fullfile(cell2str(foldernames(i)),'*.mat');
    theFiles = dir(filePattern);
   for j = 1:size(theFiles)
       cd(cell2str(createdfoldernames(i)))
       load(theFiles(j).name)
       fnirsdata.fnirstype = fnirsdata.fnirstype(:,keepindex);
       fnirsdata.data = fnirsdata.data(:,keepindex);
       

       save(fnirsdata.name,'fnirsdata','-mat')
       cd ..\
   end

end

%% Channel Config Determine Intersections

createdfoldernames_dim = size(createdfoldernames);
createdfoldernames_dim = createdfoldernames_dim(2);
for i = 1:createdfoldernames_dim
    filePattern = fullfile(cell2str(foldernames(i)),'*.mat');
    theFiles = dir(filePattern);
   for j = 1:size(theFiles)
       ChComb = {};
       cd(cell2str(createdfoldernames(i)))
       load(theFiles(j).name)
       %Need to change
       for k = 1:34
       ChComb{1,k} = sprintf('A%d',k);
       ChComb{2,k} = [fnirsdata.fnirstype(1,k).sourceIndex,fnirsdata.fnirstype(1,k).detectorIndex];
       ChComb{3,k} = fnirsdata.fnirstype(1,k).detectorIndex;
       end
       fnirsdata.ChComb = ChComb;

       save(fnirsdata.name,'fnirsdata','-mat')
       cd ..\
   end

end

%% Group Intersecting Detectors
%Maybe convert for 1st file of each folder but for now all files



 for i = 1:createdfoldernames_dim
     for k = 1:30
        eval(sprintf('Detector%d = {};',k));
     end

    filePattern = fullfile(cell2str(foldernames(i)),'*.mat');
    theFiles = dir(filePattern);
    cd(cell2str(createdfoldernames(i)))
    load(theFiles(1).name)
    %needa change
     for j = 1:34
         detectorvalue = fnirsdata.ChComb{3,j};
%          detectorsize = eval(size(sprintf('Detector%d;',detectorvalue)));
%          detectorsize = detectorsize(2);
         eval(sprintf('Detector%d{1,end+1} = fnirsdata.ChComb{1,j}; ',detectorvalue));
     end
     ChannelComb = struct;
     for m = 1:30
         eval(sprintf('ChannelComb.Detector%d = Detector%d;',m,m));
     end

save("Channel_Comb.mat",'ChannelComb','-mat')
    cd ..\

end

% for i=1:10
%   eval(sprintf('A%d = [1:i]', i));
% end
clear


