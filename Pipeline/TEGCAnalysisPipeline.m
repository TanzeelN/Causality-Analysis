function TEGCAnalysisPipeline(Datasets)
%TEGCAnalysisPipeline: Runs complete analysis aspect of pipeline for experiments which are ready. 
%--------------------------------------------------------------------------
% * Example
%   From the currentpath there should be an overall experiment folder and
%   within it should be dataset folders.
%   
%   To run the function:
%
%   Datasets = 'Experiment Name'
%   TEGCAnalysisPipeline(Datasets)
% -------------------------------------------------------------------------
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%    - Granger_Cause(Referenced in thesis)
%    - Natsortfiles (Referenced in thesis)
%
% This function can be called by:
%       TEGCAnalysisPipeline(Datasets)  
%
% * INPUT PARAMETERS
%
%   Datasets = On the current path of matlab, the names of the experiments
%   which contain datasets ready to be analysed. Data must be passed in a 
%   1xn Cell Array.
%           
%   
%   
%
% * OUTPUT
%   
%   The dataset folders should each have an updated results folder containing:
%       - TEResults.mat: Raw TRENTOOL Results
%       - Three folders (TE, MI, GC) which each contain the directed graphs
%         determined
%       - "Hemmings_Results.mat": Containg the distribution of Structural
%       hamming distances depending on number of trials and the Wilcoxon
%       Ranksum test.
%       - "Kruskal_Results.mat: Containing the distribution of strucutral
%       Hamming Distance and the Kruskal-Wallis test results.
%    Each Experiment folder should contain:
%       - "Hemmings_Results.mat": Containg the distribution of Structural
%       hamming distances for all datasets depending on number of trials and the Wilcoxon
%       Ranksum test.
%       - "Kruskal_Results.mat: Containing the distribution of strucutral
%       Hamming Distance for all datasets and the Kruskal-Wallis test results.
%           


NumberOfDatasets = size(Datasets,2);
    for i = 1:NumberOfDatasets
        ExecuteTE(Datasets(i))
        TEAnalysis(Datasets(i))
        GCAnalysis(Datasets(i))
        StatisticalTesting(Datasets(i))
        CombineHammings(Datasets(i))
        UTestAll((Datasets(i)))
        UTestEachDataset(Datasets(i))
        KruskalAll(Datasets(i))
        KruskalEachDataset(Datasets(i))
    end


end

