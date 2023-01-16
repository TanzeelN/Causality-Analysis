function StatisticalTesting(Datasets)
%Statistical Testing: Determines the SHD for every dataset in every 
% experiment comparing all three metrics (TE,MI,GC) to the ground truth and
% comparing each metric to each other(TE/MI TE/ GC, MI,GC ). This is done
% by executing the subfunction StatisticalTesting_Func.
%-------------------------------------------------------------------------
%   Example
%   To run the function:
%
%   Datasets = {'Experiment1','Experiment2'}
%   Homer2AnalysisPipeline(Datasets)
% -------------------------------------------------------------------------
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%
% This function can be called by:
%       StaitsticalTesting(Datasets)  
%
% * INPUT PARAMETERS
%
%   Datasets = On the current path of matlab, the names of the experiments
%   which contain datasets which have the metrics executed and effective 
%   connectivity maps have already been determined to compare
%   Data must be passed in a 1xn Cell Array.
%           
%   
%
% * OUTPUT
%   The Experiment\dataset\result\ folder should be updated to:
%      - including a "hemmingsresults.mat" with the SHD results.

    %Number of experiments are determiend to iterate through
    NumberOfDatasets = size(Datasets,2);
    for i = 1:NumberOfDatasets
        cd(cell2str(Datasets(i)))
        filePattern = fullfile('Results');
        theFiles = dir(filePattern);
        empty = isempty(theFiles);
        if empty == 1
            folderdirs = dir(fullfile('Dataset_*'));
            numberoffolders = size(folderdirs,1);
            for j = 1:numberoffolders
                cd(folderdirs(j).name)
                name = folderdirs(j).name;
                %When Results folder is entered, Sub function is run.
                StatisticalTesting_Func()
                cd ..\
            end
                
                 
        else

            %Execute Here
            name = cell2str(Datasets(i));
            StatisticalTesting_Func()
            cd ..\
        end
        cd ..\
    end

end




