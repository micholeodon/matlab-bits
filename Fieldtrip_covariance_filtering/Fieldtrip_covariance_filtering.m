clear; close all; clc;

% NOTE: provide path to your fieldtrip plugin directory !
addpath '/home/michak/matlab_conf_plug_lic/fieldtrip-20180526/';

%%
load('./some_data/data_clean_1.mat')
srate = 250;
dt = 1/srate;

% wavelet filtering (quite time-consuming ...)
% cfg = [];
% cfg.channel    = 'MEG';	                
% cfg.method     = 'wavelet';                
% cfg.width      = 7; 
% cfg.output     = 'pow';	
% cfg.foi        = 1:1:120;	                
% cfg.toi        = 0:dt:1-dt;		              
% MEG_spec = ft_freqanalysis(cfg, data);


%% FILTERING
tit1 = 'option 1 - without prior filtering (bandwidth 1-120 Hz)'
disp(tit1)
data1 = data;
cfg                  = [];
cfg.covariance       = 'yes';
cfg.covariancewindow = 'all';
cfg.vartrllength     = 0;
TL1             = ft_timelockanalysis(cfg, data1);

tit2 = 'option 2 - with prior LP filtering (bandwidth 1-60 Hz)'
disp(tit2)
cfg = [];
cfg.lpfilter       = 'yes';        % enable low-pass filtering
cfg.lpfreq         = 60;          % set up the frequency for low-pass filter
data2             = ft_preprocessing(cfg,data);

tit3 = 'option 3 - with prior LP filtering (bandwidth 1-30 Hz)'
disp(tit3)
cfg = [];
cfg.hpfilter       = 'no';        % enable high-pass filtering
cfg.lpfilter       = 'yes';        % enable low-pass filtering
cfg.lpfreq         = 30;          % set up the frequency for low-pass filter
cfg.dftfilter      = 'no';        % enable notch filtering to eliminate power line noise
data3             = ft_preprocessing(cfg,data);

tit4 = 'option 4 - with prior BP filtering (bandwidth 30-60 Hz)'
disp(tit4)
cfg                = [];                
cfg.hpfilter       = 'yes';        % enable high-pass filtering
cfg.lpfilter       = 'yes';        % enable low-pass filtering
cfg.hpfreq         = 30;           % set up the frequency for high-pass filter
cfg.lpfreq         = 60;          % set up the frequency for low-pass filter
data4               = ft_preprocessing(cfg,data);

tit5 = 'option 5 - with prior HP filtering (bandwidth 60-120 Hz)'
disp(tit5)
cfg                = [];                
cfg.hpfilter       = 'yes';        % enable high-pass filtering
cfg.hpfreq         = 60;           % set up the frequency for high-pass filter
data5               = ft_preprocessing(cfg,data);

tit6 = 'option 6 - with prior BP filtering (bandwidth 1-30,60-120 Hz)'
disp(tit6)
cfg                = [];                
cfg.hpfilter       = 'yes';        % enable high-pass filtering
cfg.lpfilter       = 'yes';        % enable low-pass filtering
cfg.hpfreq         = 60;           % set up the frequency for high-pass filter
cfg.lpfreq         = 30;          % set up the frequency for low-pass filter
data6            = ft_preprocessing(cfg,data);


%% COVARIANCE
cfg                  = [];
cfg.covariance       = 'yes';
cfg.covariancewindow = 'all';
cfg.vartrllength     = 0;
TL1             = ft_timelockanalysis(cfg, data1);
TL2             = ft_timelockanalysis(cfg, data2);
TL3             = ft_timelockanalysis(cfg, data3);
TL4             = ft_timelockanalysis(cfg, data4);
TL5             = ft_timelockanalysis(cfg, data5);
TL6             = ft_timelockanalysis(cfg, data6);

%% PLOTTING

TL = {TL1, TL2, TL3, TL4, TL5, TL6};
% titles
TIT = {tit1, tit2, tit3, tit4, tit5, tit6};

% figure
figure
N = 3;
M = 2;
for ii = 1:N*M
    subplot(N,M,ii)
    imagesc(TL{ii}.cov)
    colorbar
    title(TIT{ii})
    axis square
end