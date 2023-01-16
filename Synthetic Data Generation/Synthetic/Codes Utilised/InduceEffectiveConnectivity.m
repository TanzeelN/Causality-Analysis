
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
        x = data.trial{1,j}(1,:);
        time = data.time{1,j};
        time(1,10501:10530)=210.02:0.02:210.60;
        data.time{1,j} = time;
        
        y(1:20)=0;
        y(21:10520) = data.trial{1,j}(2,:)+0.5*x;
        
        z(1:25) = 0;
        z(26:10525) = data.trial{1,j}(3,:)+0.5*y(21:10520);
        
        w(1:30) = 0;
        w(31:10530)=data.trial{1,j}(4,:)+0.5*x(1:10500)+0.25*y(21:10520);
        x(10501:10530) = 0;
        y(10521:10530) = 0;
        z(10526:10530) = 0;
        trial = [x; y; z; w];
        data.trial{1,j} = trial ;
    end
    save(sprintf("%s",dataset.name),'data','-mat')
    cd ..\
end
    
