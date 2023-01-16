function Homer2AnalysisPipeline(Datasets)
%Homer2AnalysisPipeline: Converts pre-processed Homer3 fNIRS files into a FieldTrip data format. 
%--------------------------------------------------------------------------
% * Example
%   From the currentpath the folder and subfolder should exist:
%   /Dataset_Experiment/homerOutput
%   
%   To run the function:
%
%   Datasets = 'Dataset_Experiment'
%   Homer2AnalysisPipeline(Datasets)
% -------------------------------------------------------------------------
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%
% This function can be called by:
%       Homer2AnalysisPipeline(Datasets)  
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
%   The dataset folders should be updated to:
%       - homerOutput
%       - subfolders: Based on the groups within within the homerOutput to seperate the datasets 
%           Each Subfolder Contains:
%           - Results: An empty directory
%           - FieldTripDataset_*.mat: The resultant dataset file.
%           - TRENTCHCombs.mat: From the probe data, all potential
%           combination of channels that effective connectivity can be
%           determined for.
%% Homer2AnalysisPipeline
    %Runs the subfunctions for each Dataset inputed into the function.
    NumberOfDatasets = size(Datasets,2);
    for i = 1:NumberOfDatasets
        RetrieveHomer3Data(cell2str(Datasets(i)))
        Convert2FieldTrip(cell2str(Datasets(i)))
        RelocateData(cell2str(Datasets(i)))
    end
end


