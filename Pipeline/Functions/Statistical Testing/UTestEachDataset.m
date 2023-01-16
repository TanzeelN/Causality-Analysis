function UTestEachDataset(datasets)
%UTestEachDataset: Performs RankSum Wilcoxon test for every dataset individually 
% within an experiment and also performs the sidak procedure for the
% multiple comparisons problems. 
%--------------------------------------------------------------------------
% * Example
%   
%   To run the function:
%
%   Datasets = {'Dataset_Experiment'}
%   Homer2AnalysisPipeline(Datasets)
% -------------------------------------------------------------------------
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%
% This function can be called by:
%       UTestEachDataset(Datasets,NumberOfDatasets)  
%
% * INPUT PARAMETERS
%
%   Datasets = On the current path of matlab, the names of the experiments
%   where each dataset has "HemmingsResults.mat" to perform the statistical
%   test. a 1xn cell array.
%   
%   
%
% * OUTPUT
%   
%   Each Experiment/Dataset/Results folder should have an updated 
%   "HemmingsResults.mat" with the results of the statistical test appended
%   on the bottom.



names = datasets;
numberofdatasets = size(names,2);

for i = 1:numberofdatasets
    cd(cell2str(names(i)))
    secondarydatasets = fullfile('Dataset*');
    secondarydatasetsname = {dir(secondarydatasets).name};
    sizeofsecondary = size(secondarydatasetsname,2);
    %Depending on the number of datasets, the sidak procedure formula is
    %applied to determine the new alpha for significance.
    newalpha = 1-(1-0.05)^(1/numberofdatasets);
    for j = 1:sizeofsecondary
        cd(cell2str(secondarydatasetsname(j)))
        cd('Results')
        load("HemmingsFinal.mat")
        Hemmings_Results.data{9,4} = {'Wilcoxon rank sum test'};
        Hemmings_Results.data{10,4} = {'P-Value'};
        Hemmings_Results.data{11,4} = {'Result'};
        Hemmings_Results.data{9,5} = {'Transfer Entropy/Granger'};
        Hemmings_Results.data{9,6} = {'Transfer Entropy/ MI'};
        Hemmings_Results.data{9,7} = {'MI/Granger'};
        Hemmings_Results.data{12,4} = {'Effect Size(Effect)'};
        Hemmings_Results.data{13,4} = {'Effect Size (Confidence Intervals'};
        Hemmings_Results.data{14,4} = 'RankSum Score';
    
        TE_GT = cell2mat(Hemmings_Results.data(2,2:end));
        GS_GT = cell2mat(Hemmings_Results.data(3,2:end));
        MI_GT = cell2mat(Hemmings_Results.data(5,2:end));
        EffectSizeTEGC = meanEffectSize(TE_GT,GS_GT,paired = 'on');
        [p,h,stats] = ranksum(TE_GT,GS_GT,alpha = newalpha);
        Hemmings_Results.data{10,5} = p;
        Hemmings_Results.data{11,5} = h;
        %Effect Size and confidence intervals are also appended.
        Hemmings_Results.data{12,5} = EffectSizeTEGC.Effect;
        Hemmings_Results.data{13,5} = round(EffectSizeTEGC.ConfidenceIntervals,3);
        Hemmings_Results.data{14,5} = stats.ranksum;
        EffectsizeTEMI = meanEffectSize(TE_GT,MI_GT,paired = 'on');
        [p,h,stats] = ranksum(TE_GT,MI_GT,alpha = newalpha);
        Hemmings_Results.data{10,6} = p;
        Hemmings_Results.data{11,6} = h;
        Hemmings_Results.data{12,6} = EffectsizeTEMI.Effect;
        Hemmings_Results.data{13,6} = round(EffectsizeTEMI.ConfidenceIntervals,3);
        Hemmings_Results.data{14,6} = stats.ranksum;
        EffectsizeMIGS = meanEffectSize(TE_GT,MI_GT,paired = 'on');
        [p,h,stats] = ranksum(MI_GT,GS_GT,alpha = newalpha);
        Hemmings_Results.data{10,7} = p;
        Hemmings_Results.data{11,7} = h;
        Hemmings_Results.data{12,7} = EffectsizeMIGS.Effect;
        Hemmings_Results.data{13,7} = round(EffectsizeMIGS.ConfidenceIntervals,3);
        Hemmings_Results.data{14,7} = stats.ranksum;
        
        
        Hemmings_Results.data{16,4} = 'Alpha';
        Hemmings_Results.data{16,5} = 0.05;
        Hemmings_Results.data{17,4} = 'Degrees Of Freedom';
        Hemmings_Results.data{17,5} = numberofdatasets-1;
        
        
        save("HemmingsFinal.mat", 'Hemmings_Results','-mat')
        cd ..\
        cd ..\
    end
    cd ..\
end


end