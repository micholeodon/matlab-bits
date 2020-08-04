clear; close all; clc;

addpath ./aux

% Lunneborg p. 100, Figure 7.4
L = [576 635 558 578 666 ...
    580 555 661 651 605 ...
    653 575 545 572 594 ...
    ]
G = [3.39 3.30 2.81 3.03 3.44 ...
    3.07 3.00 3.43 3.36 3.13 ...
    3.12 2.74 2.76 2.88 2.96
    ]

N  = numel(L); % sample size
NN = 82; % population size
BT = 1000; % number of randomly chosen bootstrap samples

%% Calculate Target Statistic in Original Sample
TSTAT = corr(L', G')

%% Form Estimated Population of Cases
CID = 1:N
K   = NN/N 
IK  = floor(K) % how many N can fill up NN?
PEST    = repmat(CID,1,IK) % population estimate (to be expanded later)
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
TSTAR = nan(1,BT);
SEL_CASES = nan(BT,N);
for ii = 1:B100
    if NR > 0
        PEST = PEST(1:IKN);
        SID = CID(randperm(N))
        SID = SID(1:NR)
        PEST = [PEST, SID]
    end
    
    for jj = 1:100
        c = c+1;
        SPEST = PEST(randperm(NN))
        BSAMP = SPEST(1:N)
        SEL_CASES(c,:) = BSAMP;
        % calculate target statistic in resample
        SAMPL = L(BSAMP);
        SAMPG = G(BSAMP);
        TSTAR(c) = corr(SAMPL', SAMPG');
        
    end
    
end

%% VISUALIZATIONS

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
histogram(TSTAR)
title({'Sampling distribuion for t*', '(bootstrap estimate for target statistic)'})
vline(TSTAT)
annotation('textarrow',[0.5 0.67],[0.85 0.85],'String', ['t(1) =  ', num2str(TSTAT)])
