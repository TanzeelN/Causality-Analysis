function KruskalAll(datasets)

%KruskalAll: Performs Kruskal-Wallis test for every dataset combined  
% within an experiment 
%--------------------------------------------------------------------------
% * Example
%   
%   To run the function:
%
%   Datasets = {'Dataset_Experiment'}
%   UTestAll(Datasets)
% -------------------------------------------------------------------------
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%
% This function can be called by:
%       UTestAll(Datasets)  
%
% * INPUT PARAMETERS
%
%   Datasets = On the current path of matlab, the names of the experiments
%   where there is an overall "HemmingsResults.mat" to perform the statistical
%   test. a 1xn cell array.
%   
%   
%
% * OUTPUT
%   
%   Each Experiment/ folder should have an updated 
%   "Kruskal_Results.mat" with the results of the statistical test appended
%   on the bottom.





names = datasets;

numberofdatasets = size(names,2);

for i = 1:numberofdatasets
    cd(cell2str(names(i)))
    load("Hemmings_Results.mat")
    Hemmings_Results.data = Hemmings_Results.data(1:8,:);
    Hemmings_Results.data{9,4} = {'kruskalwallis'};
    Hemmings_Results.data{10,4} = {'Table:'};
    Hemmings_Results.data{11,4} = {'P'};
    Hemmings_Results.data{12,4} = {'stats'};
    
    TE_GT = cell2mat(Hemmings_Results.data(2,2:end));
    GS_GT = cell2mat(Hemmings_Results.data(3,2:end));
    MI_GT = cell2mat(Hemmings_Results.data(5,2:end));
    x = [TE_GT',GS_GT',MI_GT'];
    [p,tbl,stats] = kruskalwallis(x);
    

    
    Hemmings_Results.data{10,5} = tbl;
    Hemmings_Results.data{11,5} = p;
    Hemmings_Results.data{12,5} = stats;
    
    save("Kruskal_Results.mat", 'Hemmings_Results','-mat')
    cd ..\
end
 
        
      
end