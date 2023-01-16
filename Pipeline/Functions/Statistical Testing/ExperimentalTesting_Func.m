function StatisticalTesting_Func()
%This was used purely to compare different variables for SHD in regards to
%the experimental data. The results extracted would be shown in the thesis.
    name = {dir(fullfile("Dataset*","FieldTripDataset*.mat")).name};
    GS_Pre = dir(fullfile('Dataset_1. Pre','GoldStandardGC.mat'));
    TE_Pre = dir(fullfile('Dataset_1. Pre','GoldStandardTE.mat'));
    MI_Pre = dir(fullfile('Dataset_1. Pre','GoldStandardMI.mat'));

    GS_Post = dir(fullfile('Dataset_2. Post','GoldStandardGC.mat'));
    TE_Post = dir(fullfile('Dataset_2. Post','GoldStandardTE.mat'));
    MI_Post = dir(fullfile('Dataset_2. Post','GoldStandardMI.mat'));

    GS_Retention = dir(fullfile('Dataset_3. Retention','GoldStandardGC.mat'));
    TE_Retention = dir(fullfile('Dataset_3. Retention','GoldStandardTE.mat'));
    MI_Retention = dir(fullfile('Dataset_3. Retention','GoldStandardMI.mat'));
    



    
    filePattern_TE_Pre = fullfile('Dataset_1. Pre','Results','TE','Trial*.mat');
    theFiles_TE_Pre = dir(filePattern_TE_Pre);
    theFiles_TE_Pre = natsortfiles(theFiles_TE_Pre);

    filePattern_TE_Post = fullfile('Dataset_2. Post','Results','TE','Trial*.mat');
    theFiles_TE_Post = dir(filePattern_TE_Post);
    theFiles_TE_Post = natsortfiles(theFiles_TE_Post);

    filePattern_TE_Retention = fullfile('Dataset_3. Retention','Results','TE','Trial*.mat');
    theFiles_TE_Retention = dir(filePattern_TE_Retention);
    theFiles_TE_Retention = natsortfiles(theFiles_TE_Retention);
%MI    
    
    filePattern_MI_Pre = fullfile('Dataset_1. Pre','Results','MI','Trial*.mat');
    theFiles_MI_Pre = dir(filePattern_MI_Pre);
    theFiles_MI_Pre = natsortfiles(theFiles_MI_Pre);

    filePattern_MI_Post = fullfile('Dataset_2. Post','Results','MI','Trial*.mat');
    theFiles_MI_Post = dir(filePattern_MI_Post);
    theFiles_MI_Post = natsortfiles(theFiles_MI_Post);

    filePattern_MI_Retention = fullfile('Dataset_3. Retention','Results','MI','Trial*.mat');
    theFiles_MI_Retention = dir(filePattern_MI_Retention);
    theFiles_MI_Retention = natsortfiles(theFiles_MI_Retention);
%GC
    name = {dir(fullfile("Dataset*","FieldTripDataset*.mat")).name};
    filePattern_GC_Pre = fullfile('Dataset_1. Pre','Results','GC','Trial*.mat');
    theFiles_GC_Pre = dir(filePattern_GC_Pre);
    theFiles_GC_Pre = natsortfiles(theFiles_GC_Pre);

    filePattern_GC_Post = fullfile('Dataset_2. Post','Results','GC','Trial*.mat');
    theFiles_GC_Post = dir(filePattern_GC_Post);
    theFiles_GC_Post = natsortfiles(theFiles_GC_Post);

    filePattern_GC_Retention = fullfile('Dataset_3. Retention','Results','GC','Trial*.mat');
    theFiles_GC_Retention = dir(filePattern_GC_Retention);
    theFiles_GC_Retention = natsortfiles(theFiles_GC_Retention);
    
    %Template Hammings Mat
    NumberOfTrial = size(theFiles_TE_Pre,1);
    NumberOfTrial = NumberOfTrial(1);

    ExperimentalComparison_Results = struct;
    ExperimentalComparison_Results.data = {};
    ExperimentalComparison_Results.data{1,1} = 'Trial Number';
    ExperimentalComparison_Results.data{2,1} = 'Pre/Post TE';
    ExperimentalComparison_Results.data{3,1} = 'Pre/Post MI';
    ExperimentalComparison_Results.data{4,1} = 'Pre/Post GC';
    ExperimentalComparison_Results.data{5,1} = 'Pre/Retention TE';
    ExperimentalComparison_Results.data{6,1} = 'Pre/Retention MI';
    ExperimentalComparison_Results.data{7,1} = 'Pre/Retention GC';
    ExperimentalComparison_Results.data{8,1} = 'Post/Retention TE';
    ExperimentalComparison_Results.data{9,1} = 'Post/Retention MI';
    ExperimentalComparison_Results.data{10,1} = 'Post/Retention GC';
    ExperimentalComparison_Results.data{12,1} = 'Pre/Subj1 GC';
    ExperimentalComparison_Results.data{13,1} = 'Pre/Subj1 TE';
    ExperimentalComparison_Results.data{14,1} = 'Pre/Subj1 MI';
    ExperimentalComparison_Results.data{15,1} = 'Post/Subj1 GC';
    ExperimentalComparison_Results.data{16,1} = 'Post/Subj1 TE';
    ExperimentalComparison_Results.data{17,1} = 'Post/Subj1 MI';
    ExperimentalComparison_Results.data{18,1} = 'Retention/Subj1 GC';
    ExperimentalComparison_Results.data{19,1} = 'Retention/Subj1 TE';
    ExperimentalComparison_Results.data{20,1} = 'Retention/Subj1 MI';
    
    for k = 1:26
        %TE
        cd('Dataset_1. Pre')
        load(GS_Pre.name)
        load(TE_Pre.name)
        load(MI_Pre.name)
        GT_TE_Pre = adjacency(TE_Graph);
        GT_GC_Pre = adjacency(GC_Graph);
        GT_MI_Pre = adjacency(MI_Graph);
        cd('Results\TE')
        load(theFiles_TE_Pre(k).name)
        TE_Pre_adj = adjacency(TE_Graph);
        cd ..\..\..
        cd('Dataset_2. Post')
        load(MI_Post.name)
        load(TE_Post.name)
        load(GS_Post.name)
        GT_TE_Post = adjacency(TE_Graph);
        GT_GC_Post = adjacency(GC_Graph);
        GT_MI_Post = adjacency(MI_Graph);
        cd('Results\TE')
        load(theFiles_TE_Post(k).name)
        TE_Post_adj = adjacency(TE_Graph);
        cd ..\..\..
        cd('Dataset_3. Retention')
        load(TE_Retention.name)
        load(GS_Retention.name)
        load(MI_Retention.name)
        GT_TE_Retention = adjacency(TE_Graph);
        GT_GC_Retention = adjacency(GC_Graph);
        GT_MI_Retention = adjacency(MI_Graph);
        cd('Results\TE')
        load(theFiles_TE_Retention(k).name)
        TE_Retention_adj = adjacency(TE_Graph);
        cd ..\..\..

        %MI
        cd('Dataset_1. Pre\Results\MI')
        load(theFiles_MI_Pre(k).name)
        MI_Pre_adj = adjacency(MI_Graph);
        cd ..\..\..
        cd('Dataset_2. Post\Results\MI')
        load(theFiles_MI_Post(k).name)
        MI_Post_adj = adjacency(MI_Graph);
        cd ..\..\..
        cd('Dataset_3. Retention\Results\MI')
        load(theFiles_MI_Retention(k).name)
        MI_Retention_adj = adjacency(MI_Graph);
        cd ..\..\..

        %GC
        cd('Dataset_1. Pre\Results\GC')
        load(theFiles_GC_Pre(k).name)
        GC_Pre_adj = adjacency(GC_Graph);
        cd ..\..\..
        cd('Dataset_2. Post\Results\GC')
        load(theFiles_GC_Post(k).name)
        GC_Post_adj = adjacency(GC_Graph);
        cd ..\..\..
        cd('Dataset_3. Retention\Results\GC')
        load(theFiles_GC_Retention(k).name)
        GC_Retention_adj = adjacency(GC_Graph);
        cd ..\..\..
        
        
        Normalize_TE = 118;
        Normalize_GC = 118;
        %size(TE_Graph.Nodes,1)*size(TE_Graph.Nodes,1)-size(TE_Graph.Nodes,1);
        %*size(TE_Pre_adj,1)-size(TE_Pre_adj,1);
        %Pre/Post
        TE_Pre_Post = nnz(xor(TE_Pre_adj,TE_Post_adj))/Normalize_TE;
        MI_Pre_Post = nnz(xor(MI_Pre_adj,MI_Post_adj))/Normalize_TE;
        GC_Pre_Post = nnz(xor(GC_Pre_adj,GC_Post_adj))/Normalize_GC;
        %Pre/Retention
        TE_Pre_Retention = nnz(xor(TE_Pre_adj,TE_Retention_adj))/Normalize_TE;
        MI_Pre_Retention = nnz(xor(MI_Pre_adj,MI_Retention_adj))/Normalize_TE;
        GC_Pre_Retention = nnz(xor(GC_Pre_adj,GC_Retention_adj))/Normalize_GC;
        %Post/Retention
        TE_Post_Retention = nnz(xor(TE_Post_adj,TE_Retention_adj))/Normalize_TE;
        MI_Post_Retention = nnz(xor(MI_Post_adj,MI_Retention_adj))/Normalize_TE;
        GC_Post_Retention = nnz(xor(GC_Post_adj,GC_Retention_adj))/Normalize_GC;

        GTTE_Pre_SHD =  nnz(xor(GT_TE_Pre,TE_Pre_adj))/Normalize_TE;
        GTGC_Pre_SHD =  nnz(xor(GT_GC_Pre,GC_Pre_adj))/Normalize_TE;
        GTMI_Pre_SHD =  nnz(xor(GT_MI_Pre,MI_Pre_adj))/Normalize_TE;

        GTTE_Post_SHD =  nnz(xor(GT_TE_Post,TE_Post_adj))/Normalize_TE;
        GTGC_Post_SHD =  nnz(xor(GT_GC_Post,GC_Post_adj))/Normalize_TE;
        GTMI_Post_SHD =  nnz(xor(GT_MI_Post,MI_Post_adj))/Normalize_TE;

        GTTE_Retention_SHD =  nnz(xor(GT_TE_Retention,TE_Retention_adj))/Normalize_TE;
        GTGC_Retention_SHD =  nnz(xor(GT_GC_Retention,GC_Retention_adj))/Normalize_TE;
        GTMI_Retention_SHD =  nnz(xor(GT_MI_Retention,MI_Retention_adj))/Normalize_TE;

        
        
        ExperimentalComparison_Results.data(2,k+1)= num2cell(TE_Pre_Post);
        ExperimentalComparison_Results.data(3,k+1)= num2cell(MI_Pre_Post);
        ExperimentalComparison_Results.data(4,k+1)= num2cell(GC_Pre_Post);

        ExperimentalComparison_Results.data(5,k+1)= num2cell(TE_Pre_Retention);
        ExperimentalComparison_Results.data(6,k+1)= num2cell(MI_Pre_Retention);
        ExperimentalComparison_Results.data(7,k+1)= num2cell(GC_Pre_Retention);

        ExperimentalComparison_Results.data(8,k+1)= num2cell(TE_Post_Retention);
        ExperimentalComparison_Results.data(9,k+1)= num2cell(MI_Post_Retention);
        ExperimentalComparison_Results.data(10,k+1)= num2cell(GC_Post_Retention);

        ExperimentalComparison_Results.data(12,k+1)= num2cell(GTGC_Pre_SHD);
        ExperimentalComparison_Results.data(13,k+1)= num2cell(GTTE_Pre_SHD);
        ExperimentalComparison_Results.data(14,k+1)= num2cell(GTMI_Pre_SHD);
        ExperimentalComparison_Results.data(15,k+1)= num2cell(GTGC_Post_SHD);
        ExperimentalComparison_Results.data(16,k+1)= num2cell(GTTE_Post_SHD);
        ExperimentalComparison_Results.data(17,k+1)= num2cell(GTMI_Post_SHD);
        ExperimentalComparison_Results.data(18,k+1)= num2cell(GTGC_Retention_SHD);
        ExperimentalComparison_Results.data(19,k+1)= num2cell(GTTE_Retention_SHD);
        ExperimentalComparison_Results.data(20,k+1)= num2cell(GTMI_Retention_SHD);
        
        
        
        
        
        
        ExperimentalComparison_Results.data(1,k+1) = {k};

    end

    save("ExperimentalComparison_Results.mat","ExperimentalComparison_Results")




end
