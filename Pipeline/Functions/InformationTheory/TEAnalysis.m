function TEAnalysis(Datasets)
%TEAnalysis: To run this function assign the experiments to be considered
%in a 1xn cell array and input it within this function. This function runs
%two sub functions which are 'TEAnalysis_Func' and 'MI_Analysis_Func' to
%determine the effective connectivity maps for TE and MI.
% -------------------------------------------------------------------------
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%   
% * INPUT
%   - datasets: 1xn cell array with the experiment names to be considered. 
%
% * OUTPUT
%   
%   Within each experiment\dataset\result folder, it should be updated to:
%       - Including a 'TE' folder:
%           - Contains n .png of n trials with each .png displaying an
%           effective connectivity maps calculated.
%           - .mat file with the directed graph stored in matlab format.
%       - Including a 'MI' folder:
%           - Contains n .png of n trials with each .png displaying an
%           effective connectivity maps calculated.
%           - .mat file with the directed graph stored in matlab format.
     
    
    NumberOfDatasets = size(Datasets,2);
    for i = 1:NumberOfDatasets
        cd(cell2str(Datasets(i)))
        filePattern = fullfile('*.mat');
        theFiles = dir(filePattern);
        empty = isempty(theFiles);
        if empty == 1
            folderdirs = dir(fullfile('Dataset_*'));
            numberoffolders = size(folderdirs,1);
            for j = 1:numberoffolders
                cd(folderdirs(j).name)
                %Execute Here
                 TEAnalysis_Func
                 MIAnalysis_Func
                 cd ..\
            end
        else
            %Execute Here
            TEAnalysis_Func
            MIAnalysis_Func
            
        end
        cd ..\

    end
end

