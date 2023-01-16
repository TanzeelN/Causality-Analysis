function CreateTRENTCHCombs(Datasets)
%CreateTRENTCHCombs: Generates a file with all the possible channel combinations
% which can be explored. From this, it can be manually edited to remove 
% combinations which do not need to be investigated.
%--------------------------------------------------------------------------
% * Example
%   
%   To run the function:
%
%   Datasets = {'Dataset_Experiment'}
%   CreateTRENTCHCombs(Datasets)
% -------------------------------------------------------------------------
% * DEPENDENCIES
%    - Homer3 Toolbox Edition must be added to path by running 'addpaths'.
%
% This function can be called by:
%       CREATETRENTCHCombs(Datasets)  
%
% * INPUT PARAMETERS
%
%   Datasets = On the current path of matlab, the names of the experiments
%   where each dataset has a FieldTripReadyDataset for a channel combination
%   file to be made for.
%   
%   
%
% * OUTPUT
%   
%   Each Experiment/Dataset folder should have a "TRENTCHCombs.mat" file
    NumberOfDatasets = size(Datasets,2);
    for i = 1:NumberOfDatasets
        cd(cell2str(Datasets(i)));
        filePattern_2 = fullfile('FieldTripDataset*.mat');
        theFiles = dir(filePattern_2);
        load(theFiles.name)
        TEComb = struct;
        TEComb.config = {};
        %MAYBE REFERENCE
        [X,Y] = meshgrid(data.label(:),data.label(:));
        result = [X(:) Y(:)];
        result_dim = size(result);
        result_dim = result_dim(1);
                
        remove_result = [];
          
        for k = 1:result_dim
            if isequal(result(k,1),result(k,2))
                remove_result(end+1) = k;
            end
        end
         result(remove_result,:) = [];
                result_dim_new = size(result);
                result_dim_new = result_dim_new(1);
               
        for m = 1:result_dim_new
                    TEComb.config{end+1,1} = result{m,1};
                    TEComb.config{end,2} = result{m,2};
        end
        mkdir('Results')
        save("TRENTCHCombs.mat","TEComb",'-mat')
        
        cd ..\
    end
end
