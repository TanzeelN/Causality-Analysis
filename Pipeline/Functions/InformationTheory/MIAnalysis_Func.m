function MIAnalysis_Func()
%MIAnalysis_Func: To run this function utilise the function 'TEAnalysis'.
% This sub function extracts the raw Mutual Information results and determines
% the effective connectivity graphs for them.
% -------------------------------------------------------------------------
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%   
%   
%
% * OUTPUT
%   
%   Within each dataset result folder, it should be updated to:
%       - Including a 'MI' folder:
%           - Contains n .png of n trials with each .png displaying an
%           effective connectivity maps calculated.
%           - .mat file with the directed graph stored in matlab format.
     

    filePattern = fullfile("Results",'TE_Results.mat');
    theFiles = dir(filePattern);
    cd('Results')
    mkdir('MI');
    load(theFiles.name)
    MI_Results = TGA_results_GA.MImat;
    ChLabels = TGA_results_GA.sgncmb(:,1);
    ChLabels = unique(ChLabels);
    ChLabels = natsortfiles(ChLabels);
    CHcomb = TGA_results_GA.sgncmb;
    CHcomb_size = size(CHcomb);
    CHcomb_size = CHcomb_size(1);
    NumberOfTrial = size(MI_Results);
    NumberOfTrial = NumberOfTrial(2);
    for j = 1:NumberOfTrial
        directedMI = digraph;
        directedMI = addnode(directedMI,ChLabels);
        for k = 1:CHcomb_size
            a = CHcomb{k,1};
            b = CHcomb{k,2};
            MI = MI_Results(k,j);
            directedMI = addedge(directedMI,a,b,MI);
        end
        removeedge = [];
        numberNodes = size(directedMI.Edges.EndNodes);
        numberNodes = numberNodes(1);
        for l = 1:numberNodes
            reversed = flip(directedMI.Edges.EndNodes(l,:));
            firstnode = reversed(1);
            secondnode = reversed(2);
            weightofreverse= directedMI.Edges.Weight(findedge(directedMI,firstnode,secondnode));
            if directedMI.Edges.Weight(l) <= weightofreverse
                removeedge(end+1) = l;
            end
        end
        MI_Graph = rmedge(directedMI,removeedge);
        visiblity = figure('visible','off');
        plot(MI_Graph)
        
        cd('MI');
        saveas(visiblity,sprintf('Trial%d_MIGraph.png',j),'png')
        save(sprintf('Trial%d_MIGraph.mat',j),'MI_Graph','-mat')
        cd ..\
    end
       cd ..\
end