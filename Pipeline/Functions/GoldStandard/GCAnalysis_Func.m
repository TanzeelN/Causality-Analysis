function GCAnalysis_Func()
%GCAnalysis_Func: Executed through GCAnalysis and performs the 
% Granger Causality Metric for the entered dataset from the path.
%--------------------------------------------------------------------------
% Function should be utilised through GCAnalyiss. 
% -------------------------------------------------------------------------
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%    - granger_cause (has been referenced in the file itself)
%   
%   
%
% * OUTPUT
%   
%   Current dataset\results folder should be updated to:
%       - Including a 'GC' folder:
%           - Contains n .png of n trials with each .png displaying an
%           effective connectivity map calculated.
%           - .mat file with the directed graph stored in matlab format.
%
%REFERENCE: 
    
    %Loads Data and Potential Channel Combinations to analyse
    filePattern_ft = fullfile('FieldTripDataset*.mat');
    theFiles_ft = dir(filePattern_ft);
    filepattern_chcmb = fullfile('TRENTCH*.mat');
    theFiles_chcmb = dir(filepattern_chcmb);
    load(theFiles_ft.name)
    load(theFiles_chcmb.name)
    trialsize = size(data.trial);
    CHLabels = TEComb.config(:,1);
    CHLabels = unique(CHLabels);
    CHLabels = natsortfiles(CHLabels);
    trialsize = trialsize(2);
    CHcombsize = size(TEComb.config);
    CHcombsize = CHcombsize(1);
    %Performs GC on every trial iteratively
    for j = 1:trialsize
        nodes = [];
        trial = transpose(data.trial{1,j});
        GC_Graph = digraph;
        GC_Graph = addnode(GC_Graph,CHLabels);
        for k  = 1:CHcombsize
            index1 = cell2str(TEComb.config(k,1));
            index2 = cell2str(TEComb.config(k,2));
            index1 = str2double(extractAfter(index1,'A'));
            index2 = str2double(extractAfter(index2,'A'));
            data1 = trial(:,index1);
            data2 = trial(:,index2);
            stationarytest1 = adftest(data1);
            stationarytest2 = adftest(data2);
            %If time series is not stationary, perform method of
            %differencing
            if stationarytest1 == 0
                %REFERENCE
                D1 = LagOp({1,-1},'Lags',[0,1]);
                data1 = (filter(D1,data1));
            end
            if stationarytest2 == 0
                %REFERENCE
                D1 = LagOp({1,-1},'Lags',[0,1]);
                data2 = (filter(D1,data2));
            end
            try
                [F,c_v] = granger_cause(data1,data2,0.1,100);
                if F > c_v
                    nodes{end+1,1} = TEComb.config{k,1};
                    nodes{end,2} = TEComb.config{k,2};
                    GC_Graph = addedge(GC_Graph,TEComb.config{k,2},TEComb.config{k,1});
               
                end
            catch
                continue
            end
    
        end
        cd('Results')
        mkdir('GC');
        cd('GC');
        save(sprintf('Trial%d_Results.mat',j),'GC_Graph','-mat')
        visibility = figure('visible','off');
        plot(GC_Graph)
        saveas(visibility, sprintf('Trial%d_Graph.png',j),'png')
        cd ..\
        cd ..\
    end
       cd ..\
end