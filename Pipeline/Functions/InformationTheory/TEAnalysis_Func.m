function TEAnalysis_Func()
%TEAnalysis_Func: To run this function utilise the function 'TEAnalysis'.
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
%       - Including a 'TE' folder:
%           - Contains n .png of n trials with each .png displaying an
%           effective connectivity maps calculated.
%           - .mat file with the directed graph stored in matlab format.
%REFERENCE :  NATSORTFILES
     
    filePattern = fullfile("Results",'TE_Results.mat');
    theFiles = dir(filePattern);
    cd('Results')
    mkdir('TE');
    load(theFiles.name)
    TE_Results = TGA_results_GA.TEmat;
    MI_Results = TGA_results_GA.MImat;
    %Channel Combination determined and naturally sorted 
    ChLabels = TGA_results_GA.sgncmb(:,1);
    ChLabels = unique(ChLabels);
    ChLabels = natsortfiles(ChLabels);
    CHcomb = TGA_results_GA.sgncmb;
    CHcomb_size = size(CHcomb);
    CHcomb_size = CHcomb_size(1);
    NumberOfTrial = size(TE_Results);
    NumberOfTrial = NumberOfTrial(2);
    %For Each trial directed graph is determined
    for j = 1:NumberOfTrial
        directed = digraph;
        directed = addnode(directed,ChLabels);
        for k = 1:CHcomb_size
            a = CHcomb{k,1};
            b = CHcomb{k,2};
            TE = TE_Results(k,j);
            directed = addedge(directed,a,b,TE);
         end
         removeedge = [];
         numberNodes = size(directed.Edges.EndNodes);
         numberNodes = numberNodes(1);
         %Detemrinign effective connectivity by choosing the direction
         %which has the greater weighting
         for l = 1:numberNodes
             reversed = flip(directed.Edges.EndNodes(l,:));
             firstnode = reversed(1);
             secondnode = reversed(2);
             weightofreverse= directed.Edges.Weight(findedge(directed,firstnode,secondnode));
             if directed.Edges.Weight(l) <= weightofreverse
                 removeedge(end+1) = l;
            end
          end
         TE_Graph = rmedge(directed,removeedge);
         visiblity = figure('visible','off');
         plot(TE_Graph)
   
         cd('TE');
         saveas(visiblity,sprintf('Trial%d_TEGraph.png',j),'png')
         save(sprintf('Trial%d_TEGraph.mat',j),'TE_Graph','-mat')
         cd ..\
    end
    cd ..\
end