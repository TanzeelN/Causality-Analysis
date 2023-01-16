function StatisticalTesting_Func()
%StatisticalTesting_Func: This subfunction should be run through 
% 'StatisticalTesting'. This subfunction iterates through datasets and 
% determines the SHD for the metrics.
%--------------------------------------------------------------------------
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%

% * OUTPUT
%   
%   The specific results folders should update and include:
%       - "HemmingsResults.mat": which consists the SHD for the
%       combinations disucssed in the report.
%REFERENCE NATSORTFILES


    %Loads all associated trials effective connectivity maps and the
    %goldstandard
    filePattern_gs = fullfile('GoldStandard.mat');
    name = dir(fullfile("FieldTripDataset*.mat")).name;
    theFiles_gs = dir(filePattern_gs);
    filePattern_TE = fullfile('Results','TE','Trial*.mat');
    theFiles_TE = dir(filePattern_TE);
    theFiles_TE = natsortfiles(theFiles_TE);
    filePattern_baseline = fullfile('Results','GC','Trial*.mat');
    theFiles_baseline = dir(filePattern_baseline);
    theFiles_baseline = natsortfiles(theFiles_baseline);
    filePattern_MI = fullfile('Results','MI','Trial*.mat');
    theFiles_MI = dir(filePattern_MI);
    theFiles_MI = natsortfiles(theFiles_MI);
    NumberOfTrial = size(theFiles_TE);
    NumberOfTrial = NumberOfTrial(1);
    load("TRENTCHCombs.mat")
    %To normalize, divide each SHD by the number of potential edges
    Normalize = size(TEComb.config,1);
    %If groundtruth exists it can perform more combinations of SHD 
    if exist("GoldStandard.mat",'file') == 2
        load(theFiles_gs.name)
        gs_adj = adjacency(GS_Graph);
    end
    Hemmings_Results = struct;
    Hemmings_Results.data = {};
    Hemmings_Results.data{1,1} = 'Trial Number';
    Hemmings_Results.data{2,1} = 'Transfer Entropy/GroundTruth';
    Hemmings_Results.data{3,1} = 'GoldStandard/GroundTruth';
    Hemmings_Results.data{4,1} = 'TE/GoldStandard';
    Hemmings_Results.data{5,1} = 'MI/GroundTruth';
    Hemmings_Results.data{6,1} = 'TE/MI';
    Hemmings_Results.data{7,1} = 'MI/GoldStandard';
    for k = 1:NumberOfTrial
        cd('Results')
        cd('TE')
        load(theFiles_TE(k).name)
        cd ..\
        cd("GC")
        load(theFiles_baseline(k).name)
        cd ..\
        cd("MI")
        load(theFiles_MI(k).name)
        cd ..\
        cd ..\
        TE_adj = adjacency(TE_Graph);
        Basline_adj = adjacency(GC_Graph);
        MI_adj = adjacency(MI_Graph);
        if exist("GS_Graph",'var') == 1
            %SHD Formula Maybe need reference
            TE_GS = nnz(xor(TE_adj,gs_adj))/Normalize;
            Baseline_GS = nnz(xor(Basline_adj,gs_adj))/Normalize;
            MI_GS = nnz(xor(MI_adj,gs_adj))/Normalize;
            Hemmings_Results.data(2,k+1)= num2cell(TE_GS);
            Hemmings_Results.data(3,k+1)= num2cell(Baseline_GS);
            Hemmings_Results.data(5,k+1)= num2cell(MI_GS);
    
        end
        %cd ..\
    
    
        TE_Baseline = nnz(xor(TE_adj,Basline_adj))/Normalize;
        MI_TE = nnz(xor(TE_adj,MI_adj))/Normalize;
        MI_Baseline = nnz(xor(MI_adj,Basline_adj))/Normalize;
    
        Hemmings_Results.data(1,k+1) = {k};
        Hemmings_Results.data{6,k+1} = MI_TE;
        Hemmings_Results.data(4,k+1)= num2cell(TE_Baseline);
        Hemmings_Results.data{7,k+1} = MI_Baseline;
        Hemmings_Results.data(8,k+1) = {name};
    end
    cd('Results')
    save("HemmingsFinal.mat","Hemmings_Results")
    cd ..\
            
end