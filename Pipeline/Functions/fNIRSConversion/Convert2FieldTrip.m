function Convert2FieldTrip(Dataset_Name)
%This File converts Homeroutput data folder which consists of the
%preprocessed fNIRS imaging data into FieldTrip Data Format.
%Convert2FieldTrip: . 
%
% * DEPENDENCIES
%    - This function is made to be called from Homer2OutputPipeline.

%% Retrieves Data and Converts Channel and Time Data into FieldTrip Format
cd(Dataset_Name);
cd('homerOutput');

%Retrieves each individual group dataset
allfiles = dir;
allfiles_dim = size(allfiles,1);
names = {allfiles.name};
datasets = {};
% Appends each group dataset into an array
for i = 1:allfiles_dim
    if contains(names(i),'Dataset')
        datasets{end+1} = names{i};
    end
end
dataset_dim = size(datasets,2);
for i = 1:dataset_dim
   filePattern = fullfile(cell2str(datasets(i)),'*.mat');
   theFiles = dir(filePattern);
   indexvalue = find(contains({theFiles.name},'Channel_Comb.mat'));
   theFiles(indexvalue,:) = [];
   cd(cell2str(datasets(i)))
   data = struct;
   for j = 1:size(theFiles)
       load(theFiles(j).name)
       %samples per second (Hz)
       time = fnirsdata.time(:,1);
       difference = mean(diff(time));
       fsample = 1/difference;
   data.fsample = fsample;
       trial = fnirsdata.data;
       trial = transpose(trial);
       label = fnirsdata.ChComb(1,1:end);
       time = fnirsdata.time;
       time = transpose(time);
       data.trial{1,j} = trial;
       data.time{1,j} = time;
       data.label = label;
   end
   %The time series need to be identical. If time series are different
   %sizes, it will reduce all time series to match.
   verify_size = Inf;
   trials = size(data.trial,2);
   for k = 1:trials
       data_size = size(data.trial{1,k});
       data_col_size = data_size(2);
       if data_col_size <= verify_size
           verify_size = data_col_size;
       end
   end
   for k = 1:trials
       data.trial{1,k} = data.trial{1,k}(:,1:verify_size);
       data.time{1,k} = data.time{1,k}(:,1:verify_size);
   end

   
    name = datasets(i);
    name = sprintf(cell2str(name));
    
   save(sprintf('FieldTrip%s.mat',name),'data','-mat')
   
   cd ..\
end
%% Determining all channel combinations of each Source -> Detector
for i = 1:dataset_dim
   filePattern = fullfile(cell2str(datasets(i)),'Channel_Comb.mat');
   theFiles = dir(filePattern);
   cd(cell2str(datasets(i)))
   for j = theFiles
       load(j.name)
       CleanedChs = struct;
       DetectorNames = fieldnames(ChannelComb);
       DetectorNames_Size = size(DetectorNames);
       DetectorNames_Size = DetectorNames_Size(1);
       for k = 1:DetectorNames_Size
           Detector = ChannelComb.(DetectorNames{k});
           Name_Of_Detector = DetectorNames{k};
           k_size = size(Detector);
           k_size = k_size(2);
           if k_size > 1
               eval(sprintf('CleanedChs.%s = ChannelComb.(DetectorNames{%d});',Name_Of_Detector,k));
           end
           save("Cleaned_ChComb.mat","CleanedChs","-mat")
       end
   end
   cd ..\
end

%% Creates the Channel Combination file to be utilised by TRENTOOL

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


dataset_dim = size(datasets,2);
for i = 1:dataset_dim
   filePattern = fullfile(cell2str(datasets(i)),'Cleaned_ChComb.mat');
   theFiles = dir(filePattern);
   cd(cell2str(datasets(i)))
   for j = theFiles
       load(j.name)
       DetectorNames = fieldnames(CleanedChs);
       DetectorNames_Size = size(DetectorNames);
       DetectorNames_Size = DetectorNames_Size(1);
       TEComb = struct;
       TEComb.config = {};
       for l = 1:DetectorNames_Size
        Name_Of_Detector = DetectorNames{l};
        %Copied
        %Determines all combination of channels
        [X,Y] = meshgrid(CleanedChs.(DetectorNames{l}),CleanedChs.(DetectorNames{l}));
        result = [X(:) Y(:)];
        result_dim = size(result);
        result_dim = result_dim(1);
        
        remove_result = [];
        %Removes combinations where both channels are identical
        for k = 1:result_dim
           if isequal(result(k,1),result(k,2))
               remove_result(end+1) = k;
           end
        end
        result(remove_result,:) = [];
        result_dim_new = size(result);
        result_dim_new = result_dim_new(1);
       
        for m = 1:result_dim_new
            TEComb.config{end+1,1} = result{m,1};
            TEComb.config{end,2} = result{m,2};
      
        end
           
       end
       save('TRENTCHCombs.mat',"TEComb",'-mat')
   
   end  
   cd ..\  
end
cd ..\
cd ..\
end

