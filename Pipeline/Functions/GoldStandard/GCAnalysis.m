function GCAnalysis(Datasets)
%GCAnalysis: Executes Granger Causality Metric and derives the directed
% graphs by calling GCAnalysis_Func on a specific dataset. 
%--------------------------------------------------------------------------
% * Example
%   On the path where the experimental folders are: 
%   
%   To run the function assign experiment names to a cell array(1*N) and 
%   call the function as shown:
%
%   Datasets = {'Dataset_Experiment1', 'Dataset_Experiment2'}
%   GCAnalysis(Datasets)
% -------------------------------------------------------------------------
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%    - granger_cause (has been referenced in the file itself)
%
% This function can be called by:
%      GCAnalysis(Datasets)  
%
% * INPUT PARAMETERS
%
%   Datasets = On the current path of matlab, the names of the folders
%   which contain only a homerOutput folder. Data must be passed in a 
%   1xn Cell Array.
%           
%           homerOutput folder: When utilising homer3 to preprocess the
%           fNIRS files, a folder is generated called 'homerOutput' which
%           contains the fNIRS data objects. This folder must be copied,
%           and placed in the folder written in 'Datasets' 
%   
%   
%
% * OUTPUT
%   
%   Within each dataset result folder, it should be updated to:
%       - Including a 'GC' folder:
%           - Contains n .png of n trials with each .png displaying an
%           effective connectivity map calculated.
%           - .mat file with the directed graph stored in matlab format.


    %Determines the number of experiments
    NumberOfDatasets = size(Datasets,2);
    for i = 1:NumberOfDatasets
        %Enter an experiment
        cd(cell2str(Datasets(i)))
        filePattern = fullfile('Results');
        theFiles = dir(filePattern);
        empty = isempty(theFiles);
        if empty == 1
            %Determiens the number of datasets in an experiment
            folderdirs = dir(fullfile('Dataset_*'));
            numberoffolders = size(folderdirs,1);
            for j = 1:numberoffolders
                %For each dataset apply the granger causality metric
                cd(folderdirs(j).name)
                GCAnalysis_Func()
            end
            cd ..\
                 
        else
            GCAnalysis_Func()
        end
            
            
    end

end
