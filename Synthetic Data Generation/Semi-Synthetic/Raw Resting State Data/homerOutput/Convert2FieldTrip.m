%cd('homerOutput');
%Get datasets
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
data = struct;
for i = 1:dataset_dim
    %Needa Generalise
   filePattern = fullfile(cell2str(datasets(i)),'resting*.mat');
   theFiles = dir(filePattern);
   cd(cell2str(datasets(i)))
   fsample = 5.08;
   data.fsample = fsample;
   for j = 1:size(theFiles)
       load(theFiles(j).name)
       trial = fnirsdata.data;
       trial = transpose(trial);
       label = fnirsdata.ChComb(1,1:end);
       time = fnirsdata.time;
       time = transpose(time);
       data.trial{1,i} = trial;
       data.time{1,i} = time;
       data.label = label;
   end
   verify_size = Inf;
   data_col = size(data.trial);
   data_col = data_col(2);
   for k = 1:data_col
       data_size = size(data.trial{1,k});
       data_col_size = data_size(2);
       if data_col_size <= verify_size
           verify_size = data_col_size;
       end
   end
   for k = 1:data_col
       data.trial{1,k} = trial(:,1:verify_size);
   end

   


   save(sprintf('FieldTripDataset%d.mat',i),'data','-mat')
   cd ..\
end
%% Cleanup Channel_Comb


% allfiles = dir;
% allfiles_dim = size(allfiles);
% allfiles_dim = allfiles_dim(1);
% names = {allfiles.name};
% datasets = {};
% 
% for i = 1:allfiles_dim
%     if contains(names(i),'Dataset')
%         datasets{end+1} = names{i};
%     end
% end
% dataset_dim = size(datasets);
% dataset_dim = dataset_dim(2);
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

%% Collate Channel Combos into one so it can be used by Transfer Entropy Tool

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
        [X,Y] = meshgrid(CleanedChs.(DetectorNames{l}),CleanedChs.(DetectorNames{l}));
        result = [X(:) Y(:)];
        result_dim = size(result);
        result_dim = result_dim(1);
        
        remove_result = [];
    
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
