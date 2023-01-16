function TEScript(outputpath)

%%Load Data and output folder
if ~isdir(outputpath)
  error([outputpath ' is not a path. Please check!'])
end
%FieldTripDataset Name
filePattern = fullfile('FieldTripDataset*.mat');
theFiles = dir(filePattern);
load(theFiles.name);
%Channel Combinations
load('TRENTCHCombs.mat');
%% TEprepare configuration
cfgTEP = [];
%If all channels being analysed
%cfgTEP.channel = data.label; %Channel names to be analyzed
%If Specific Channels are being compared
cfgTEP.sgncmb = TEComb.config;
cfgTEP.toi = [data.time{1}(1) data.time{1}(end)]; %Time of interest

%Interaction Delay Choice
cfgTEP.predicttimemin_u    = 0;      % minimum u to be scanned
cfgTEP.predicttimemax_u    = 62;	  % maximum u to be scanned
cfgTEP.predicttimestepsize = 2; %Information Transfer delay

cfgTEP.TEcalctype = 'VW_ds'; %TE estimator
% ACT estimation and constraints on allowed ACT(autocorelation time)
%Reccommended as high as possible depending on computational power
cfgTEP.maxlag      = 5000;  % max. lag for the calculation of the ACT
cfgTEP.actthrvalue = 3000;   % threshold for ACT
%Manually Change
cfgTEP.minnrtrials = 5;    % minimum acceptable number of trials

% optimizing embedding
%Recommend As high as possible for each parameter if computation power
%permits.
cfgTEP.optimizemethod ='ragwitz';  % criterion used
cfgTEP.ragdim         = 1:10;       % dimensions d to be used
cfgTEP.ragtaurange    = [0 1]; % tau range to be used
cfgTEP.ragtausteps    = 10;         % steps for ragwitz tau
cfgTEP.repPred        = 2000;       % no. local prediction/points used for the Ragwitz criterion

% kernel-based TE estimation
%Leave Unchanged
cfgTEP.flagNei = 'Mass' ;           % type of neigbour search (knn)
cfgTEP.sizeNei = 4;                 % number of neighbours in the mass/knn search

% set the level of verbosity of console outputs
cfgTEP.verbosity = 'info_minor';

%% define cfg for TEsurrogatestats.m

cfgTESS = [];

% use individual dimensions for embedding
cfgTESS.optdimusage = 'indivdim';
%cfgTESS.embedsource = 'yes';

% statistical testing
cfgTESS.tail           = 1;
cfgTESS.numpermutation = 5e4;
cfgTESS.surrogatetype  = 'trialshuffling';
%cfgTESS.alpha = 0.75;

% shift test
%Either keep extracond or set shifttest to yes as they are mutually
%exclusive
cfgTESS.extracond = 'faes_method';
cfgTESS.shifttest      = 'no';      % don't test for volume conduction

% prefix for output data
cfgTESS.fileidout  = fullfile(outputpath,'TE_Results.mat');
TGA_results = InteractionDelayReconstruction_calculate(cfgTEP,cfgTESS,data);

%% correction 

cfgGA = [];

cfgGA.threshold = 4;    % use a threshold/error tolerance of 4 ms
cfgGA.cmc       = 1;    % use links after correction for multiple comparison

TGA_results_GA = TEgraphanalysis(cfgGA,TGA_results);
save([cfgTESS.fileidout],'TGA_results','TGA_results_GA');
