function RelocateData(Dataset_Name)
%This File relocates the homerOutput data into a FieldTrip Dataset folder
%which is compatible with TRENTOOL.
%
% * DEPENDENCIES
%    - This function is made to be called from Homer2OutputPipeline.
%% Relocates Group data to parent directory in a newly generated folder

cd(Dataset_Name);
cd('HomerOutput');

%Create Folders and move Files
allfiles = dir;
allfiles_dim = size(allfiles);
allfiles_dim = allfiles_dim(1);
names = {allfiles.name};
datasets = {};
for i = 1:allfiles_dim
    if contains(names(i),'Dataset')
        datasets{end+1} = names{i};
    end
end

dataset_dim = size(datasets);
dataset_dim = dataset_dim(2);

for i = 1:dataset_dim
   
   filePattern = fullfile(cell2str(datasets(i)),'Cleaned_ChComb.mat');
   theFiles = dir(filePattern);
   cd(cell2str(datasets(i)))
   FolderName = cell2str(datasets(i));
   Folder2Create = sprintf("../../%s",FolderName);
   %Results folder is created to run TRENTOOL
   mkdir(Folder2Create)
   mkdir(sprintf('%s/Results',Folder2Create))
   filePattern = fullfile('TRENTCHCombs.mat');
   copyfile(filePattern,Folder2Create);
   filePattern_2 = fullfile('FieldTripDataset*.mat');
   copyfile(filePattern_2,Folder2Create);
   cd ..\
end
cd ..\
cd ..\
end