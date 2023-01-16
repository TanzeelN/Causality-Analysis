function CombineHammings(datasets)
%CombineHammings: Combines every individual dataset 'HemmingResults.mat' to
% an overall experimental 'HemmingResults.mat'. 
%--------------------------------------------------------------------------
% * Example
%   From the currentpath the folder and subfolder should exist:
%   /Dataset_Experiment/homerOutput
%   
%   To run the function:
%
%   Datasets = {'Dataset_Experiment'}
%   CombineHammings(Datasets)
% -------------------------------------------------------------------------
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%
% This function can be called by:
%       CombineHammings(Datasets)  
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
%   Within each expeirmental folder stated:
%   - There will exist a 'HemmingResults.mat' file which 


numberofexperiments = size(datasets);
for i = 1:numberofexperiments
    cd(datasets{i})
    FinalHemmings_Results = struct;
    FinalHemmings_Results.data = {'Trial Number';
    'Transfer Entropy/GroundTruth';
    'GoldStandard/GroundTruth';
    'TE/GoldStandard';
    'MI/GroundTruth';
    'TE/MI';
    'MI/GoldStandard';
    'Dataset Name'};
    datasetnames = fullfile("Dataset*");
    names = {dir(datasetnames).name};
    numberofdatasets = size(names,2);
        for i = 1:numberofdatasets
        cd(cell2str(names(i)))
        cd('Results')
        load("HemmingsFinal.mat")
        %Appends every trial shd result into one file for the experiment
        Distances = size(Hemmings_Results.data,2)-1;
        FinalHemmings_Results.data(1:8,end+1:end+Distances) = Hemmings_Results.data(1:8,2:end);
        cd ..\
        cd ..\
        end
    save("Hemmings_Results.mat", 'FinalHemmings_Results','-mat')
    Hemmings_Results = FinalHemmings_Results;
    save("Hemmings_Results.mat", 'Hemmings_Results','-mat')
    
    cd ..\

end










