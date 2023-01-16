%This file was used to induce the effective connectivity with the time
%delay
folderstosearch = fullfile('Dataset*');
alldirectors = dir(folderstosearch);

numberoffolders = size(alldirectors,1);

for i = 1:numberoffolders
    cd(alldirectors(i).name)
    datasetfile = fullfile('FieldTripDataset*');
    dataset = dir(datasetfile);
    load(dataset.name)
    numberoftrials = size(data.trial,2);
    for j = 1:numberoftrials
        specifictrialsize = size(data.trial{1,1},2);
        data.trial{1,j}(:,10531:end) = [];

        data.trial{1,j}(2,1:10530) = data.trial{1,j}(2,1:10530) + syndata.trial(1,:);
        data.trial{1,j}(3,1:10530) = data.trial{1,j}(3,1:10530) + syndata.trial(2,:);
        data.trial{1,j}(15,1:10530) = data.trial{1,j}(11,1:10530) + syndata.trial(3,:);
        data.trial{1,j}(16,1:10530) = data.trial{1,j}(15,1:10530) + syndata.trial(4,:);

        data.time{1,j} = syndata.time;


    end
    save(sprintf("%s",dataset.name),'data','-mat')
    cd ..\
end
    
