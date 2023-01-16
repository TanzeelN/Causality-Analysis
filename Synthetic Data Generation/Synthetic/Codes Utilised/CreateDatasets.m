mkdir('Dataset_SynthethicfNIRS')
mkdir('Dataset_SynthethicfNIRS\Dataset_Synthethic')
mkdir('Dataset_SynthethicfNIRS\Dataset_SynBreathing')
mkdir('Dataset_SynthethicfNIRS\Dataset_SynBreHeart')
mkdir('Dataset_SynthethicfNIRS\Dataset_SynBreHeartVaso')
mkdir('Dataset_SynthethicfNIRS\Dataset_SynBreHeartVasoGauss')

datasyn = struct;
datasyn.time = {};
datasyn.trial = {};
databre = struct;
databre.time ={};
databre.trial = {};
datahear = struct;
datahear.time = {};
datahear.trial = {};
datavaso = struct;
datavaso.time = {};
datavaso.trial = {};
datagauss = struct;
datagauss.time = {};
datagauss.trial = {};
for i = 1:20
    pyrunfile("fNIRSSignalGenerator.py")
    load('fnirsdata.mat')
    synthethicdata = (hbo)';
    load('breathingdata.mat')
    synbreathing = (hbo)';
    load('fnirsheartbreathing.mat')
    synheart = (hbo)';
    load('vasomotionbreathingheartrate.mat')
    synvaso = (hbo)';
    load('gaussianontop.mat')
    syngauss = (hbo)';
    load('time.mat')
    time = time(:,1)';
    time(1) = [];
    time(1,end+1) = 209.98;
    time(1,end+1) = 210;


    
    datasyn.time{1,end+1} = time;
    datasyn.trial{1,end+1} = synthethicdata;
    datasyn.fsample=1000;
    datasyn.label = {'A1','A2','A3','A4'};

    

    
    databre.time{1,end+1} = time;
    databre.trial{1,end+1} = synbreathing;
    databre.fsample=1000;
    databre.label = {'A1','A2','A3','A4'};

    
    datahear.time{1,end+1} = time;
    datahear.trial{1,end+1} = synheart;
    datahear.fsample=1000;
    datahear.label = {'A1','A2','A3','A4'};

   
    datavaso.time{1,end+1} = time;
    datavaso.trial{1,end+1} = synvaso;
    datavaso.fsample=1000;
    datavaso.label = {'A1','A2','A3','A4'};
    

    
    datagauss.time{1,end+1} = time;
    datagauss.trial{1,end+1} = syngauss;
    datagauss.fsample=1000;
    datagauss.label = {'A1','A2','A3','A4'};
end



cd('Dataset_SynthethicfNIRS\Dataset_Synthethic')
data = datasyn;
save("FieldTripDataset_Syn.mat","data","-mat")
cd ..\

cd('Dataset_SynBreathing')
data = databre;
save("FieldTripDataset_SynBre.mat","data","-mat")
cd ..\
cd('Dataset_SynBreHeart')
data = datahear;
save("FieldTripDataset_SynBreHeart.mat","data","-mat")
cd ..\
cd('Dataset_SynBreHeartVaso')
data = datavaso;
save("FieldTripDataset_SynBreaHeartVaso.mat","data","-mat")
cd ..\
cd('Dataset_SynBreHeartVasoGauss')
data = datagauss;
save("FieldTripDataset_SynBreHeartVasoGauss.mat","data","-mat")
cd ..\