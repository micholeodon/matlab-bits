%% Prepare dataset
clear; close all; clc;

addpath ./aux

% check correlation between different life standard ratings in US
load cities.mat

categoryID_1 = 6; % 6 - eductaion
categoryID_2 = 7; % 7 - arts

name_1 = categories(categoryID_1,:);
name_2 = categories(categoryID_2,:);

% whole population ratings on selected categories
X1 = ratings(:,categoryID_1); 
X2 = ratings(:,categoryID_2);

% select single sample cases
% N > 0.05*NN => sampling without replacement
% lucky sample !
sampleCasesID = [    73   250   143   276   111   272   275   166    27    70    56    67   104   213    97    11   106   169   274    68    57   126    16    66   138   285    43    93    86   289   263   319   300   200   100 ...
   129   140   168   284   211   135    99   219   275   273   192    28   144   277     3   295   245   297   156   213   280   153   260    72   268   186   227   223    93   319   276   324   114   202   171 ...
    253    49    48   280   143   143    24    85   179   234   197    96   157    63   260   161   313   254   208   216   190    43   176    87   237   214   147    45    18   169]

% not-so-lucky sample
sampleCasesID = [289   139   229    29    40   315   324   313   129   235   156  ...
    148   186   134   294    86    46   107   127   242   246   195    ...
    87   213   163   116   221    78    96    13   149    36   288    ...
    56   119 174    74   327   280   329   125   280   178    24    33 ...
    52   199   197   204   115    11     9   260   223   291    71   131 ...
    66    82   236    25   218   325    76    96   159   225   162   264   ...
    207 236   260   122   203   132    99   232   212   225   173    64 ...
    8   288   204    47   277   245   205   258    48   248    58   278 ...
    112   172   143   273    12    29   221]; % not-so-lucky sample


% N < 0.05*NN => sampling with replacement
% sampleCasesID = [   317    81    38   131   112   273   309   104   305    83 ] % lucky sample
% sampleCasesID = [    36    84   198    14   212    15    14   183   240   159 ] % not-so-lucky sample


X1_sample = X1(sampleCasesID);
X2_sample = X2(sampleCasesID);


%% Prepare numbers
N  = numel(sampleCasesID); % sample size
NN = numel(X1); % population size
BT = 1000; % number of randomly chosen bootstrap samples

%% Calculate Target Statistic in Original Sample
t_pop = corr(X1, X2)
t_sample = corr(X1_sample, X2_sample)

%% Form Estimated Population of Cases
sampleIDs = 1:N
K   = NN/N 
IK  = floor(K) % how many N can fill up NN?
PEST    = repmat(sampleIDs,1,IK) % population estimate (to be expanded later)
IKN     = N*IK
NR = NN-IKN % remainder if NN/N is not integer; IKN + NR = NN

%% Begin bootstrap resample cycles:
B100 = BT/100 % number of resample partitions 
% If NN/Nn is not an integer, then we make c=floor(N/n) copies of 
% the real-world sample
% and add also k=N-cn elements from the real-world sample randomly. 
% Bootstrap samples we create drawing WITHOUT replacement, but, 
% to avoid additional bias / imbalance, after 100 draws we need draw k new
% elements to use in next resamples instead of old k ones.

c = 0
t_bootstr = nan(1,BT);
SEL_CASES = nan(BT,N);

if N > 0.05*NN    
    clc
    disp('WITHOUT replacement !')
    pause(2)

    for ii = 1:B100
        if NR > 0
            PEST = PEST(1:IKN);
            SID = sampleIDs(randperm(N))
            SID = SID(1:NR)
            PEST = [PEST, SID]
        end
        
        for jj = 1:100
            c = c+1;
            SPEST = PEST(randperm(NN))
            BSAMP = SPEST(1:N)
            SEL_CASES(c,:) = BSAMP;
            % calculate target statistic in resample
            SAMPL = X1_sample(BSAMP);
            SAMPG = X2_sample(BSAMP);
            t_bootstr(c) = corr(SAMPL, SAMPG);
            
        end
        
    end
else
    clc
    disp('WITH replacement !')
    pause(2)
    for ii = 1:BT
        c=c+1;
        BSAMP = randi(N,1,N)
        SEL_CASES(c,:) = BSAMP;
        % calculate target statistic in resample
        SAMPL = X1_sample(BSAMP);
        SAMPG = X2_sample(BSAMP);
        t_bootstr(c) = corr(SAMPL, SAMPG);
        
    end
    
end

%% VISUALIZATIONS
close all
% selected cases in first bootstrap sample
figure
histogram(SEL_CASES(1,:))
title('Selected cases in first bootstrap sample')

% histogram of selected cases in whole bootstrap (should be close to uniform)
figure
histogram(SEL_CASES)
title('Histogram of selected cases in whole bootstrap')

% sampling distribution for TSTAR
figure
histogram(t_bootstr)
title({'Sampling distribuion for t*', '(bootstrap estimate for target statistic)'})

vline(t_pop,'r')
vline(t_sample,'b')

dim = [0.2 0.5 0.3 0.3];
str = 'population';
ann = annotation('textbox',dim,'String',str,'FitBoxToText','on');
ann.Color = 'r';
dim = [0.2 0.42 0.3 0.3];
str = 'real-world sample';
ann = annotation('textbox',dim,'String',str,'FitBoxToText','on');
ann.Color = 'b';
