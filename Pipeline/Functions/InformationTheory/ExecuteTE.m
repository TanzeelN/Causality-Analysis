function ExecuteTE(Datasets)
%ExecuteTE: Executes the TEScript for every dataset in the selected experiments 
%
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%    - TRENTOOL3
%    - FieldTrip
% 
%
% This function can be called by:
%       ExecuteTE(datasets)
% where datasets = 1xn cell array of experiment names
%
% * INPUT PARAMETERS
%
%   Datasets = On the current path of matlab, the names of the Experiments
%   which contain FieldTrip ready Dataset folders. Data must be passed in a 
%   1xn Cell Array.
%           Each FieldTrip Ready Dataset folder must contain:
%                - Channel Combination file name 'TRENTCHCombs.mat'
%                - 'FieldTripDataset###.mat'
%                - 'TEScript.m' This can be taken from the templats folder
%                in the pipeline and pasted. The parameters will need to be
%                edited for specific datasets.
%               NOTE: If the 'Homer2AnalysisPipeline' is utilised only a TEScript.m
%               needs to be inputted. If the FieldTripDataset file was
%               manually generated the result folder, script and channel
%               combination file(Can use CreateTRENTCHCombs function to
%               generate and edit) must be manually added.
%
% * OUTPUT 
%   After the function has run, The Results folder will contain the raw
%   results of TRENTOOL for information theory based metrics.
%
%

%Determiens the number of experiments to iterate through
    NumberOfDatasets = size(Datasets,2);
    for i = 1:NumberOfDatasets
        cd(cell2str(Datasets(i)))
        filePattern = fullfile('TEScript.m');
        theFiles = dir(filePattern);
        empty = isempty(theFiles);
        if empty == 1
            folderdirs = dir(fullfile('Dataset_*'));
            numberoffolders = size(folderdirs,1);
            for j = 1:numberoffolders
                %Runs TRENTOOL Script
                cd(folderdirs(j).name)
                TEScript('Results')
                cd ..\
            end
        else
            %If there are no datasetfolders, it can still run the script
            TEScript('Results')
        end
        cd ..\
    end