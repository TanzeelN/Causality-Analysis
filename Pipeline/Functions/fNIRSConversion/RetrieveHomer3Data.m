function RetrieveHomer3Data(Dataset_Name)
%This File retrieves the data from homerOutput and determines the number of 
%dataset folders that need to be created depending on the groups/
% * DEPENDENCIES
%    - This function is made to be called from Homer2OutputPipeline.
%% Reads the fNIRS data and assigns them to variables
cd(Dataset_Name);
%Enter Folder with homer processed files
cd('homerOutput');

allfiles = dir();
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
    name = foldernames(i);
    name = sprintf('Dataset_%s',cell2str(name));
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
%% Extracts HBO data 
% As discussed in the the report [] has been used for effective
% connectivity analysis

createdfoldernames_dim = size(createdfoldernames,2);
keepindexsize = size(fnirsdata.fnirstype,2);
keepindex = 1:3:keepindexsize;
keepindexsize = size(keepindex,2);
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

%% Determines the possible channels for effective connectivity analysis
% This is done by observing intersecting source/detectors.
createdfoldernames_dim = size(createdfoldernames,2);
for i = 1:createdfoldernames_dim
    filePattern = fullfile(cell2str(foldernames(i)),'*.mat');
    theFiles = dir(filePattern);
   for j = 1:size(theFiles)
       ChComb = {};
       cd(cell2str(createdfoldernames(i)))
       load(theFiles(j).name)
       hbosize = size(fnirsdata.fnirstype,2);
       for k = 1:hbosize
       ChComb{1,k} = sprintf('A%d',k);
       ChComb{2,k} = [fnirsdata.fnirstype(1,k).sourceIndex,fnirsdata.fnirstype(1,k).detectorIndex];
       ChComb{3,k} = fnirsdata.fnirstype(1,k).detectorIndex;
       end
       fnirsdata.ChComb = ChComb;


       save(fnirsdata.name,'fnirsdata','-mat')
       cd ..\
       save("SourceDetector.mat",'ChComb','-mat')
   end

end

%% Groups Channels for effective connectiviy analysis
 for i = 1:createdfoldernames_dim
     %This will need to be updated for every experiment. 'k = 1:30' refers
     %to the number of detectors. 
     value = ChComb{2,end}(2);
     for k = 1:value
        eval(sprintf('Detector%d = {};',k));
     end

    filePattern = fullfile(cell2str(foldernames(i)),'*.mat');
    theFiles = dir(filePattern);
    cd(cell2str(createdfoldernames(i)))
    load(theFiles(1).name)
     for j = 1:keepindexsize
         detectorvalue = fnirsdata.ChComb{3,j};
         eval(sprintf('Detector%d{1,end+1} = fnirsdata.ChComb{1,j}; ',detectorvalue));
     end
     ChannelComb = struct;
     %This will need to be updated for every experiment. 'm = 1:30' refers
     %to the number of detectors
     for m = 1:value
         eval(sprintf('ChannelComb.Detector%d = Detector%d;',m,m));
     end

save("Channel_Comb.mat",'ChannelComb','-mat')
    cd ..\

end
cd ..\
cd ..\
end