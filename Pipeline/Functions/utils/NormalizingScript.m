function NormalizingScript()
%NormalizingScript: Normalizies every trials data with the minmax scalar. 
%--------------------------------------------------------------------------
% * Example
%   
%   To run the function:
%
%   
%   NormalizingScript()
%   To run this function, make sure the current path is within the dataset 
%   folder.
% -------------------------------------------------------------------------
%   
%   Each Datasets FieldTripData file will now contain normalized data.
datasets = {dir("Dataset_*").name};
numberofdatasets = size(datasets,2);

for i = 1:numberofdatasets
    cd(cell2str(datasets(i)))
    dataname = fullfile("FieldTripDataset*.mat");
    dataname = dir(dataname).name;
    load(dataname)
    trialsize = size(data.trial,2);
    for j = 1:trialsize
        data.trial{1,j}=rescale(data.trial{1,j});
    end
    save(sprintf("%s",dataname),"data",'-mat')
    cd ..\
end
