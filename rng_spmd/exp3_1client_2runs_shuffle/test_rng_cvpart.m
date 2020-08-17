clear; %clc;

%rng(123)
rng shuffle

%run init_parallel_env % moze tu jest blad? ponizej ekwiwalent tego
%kodu bez czekania na licencje
%parpool(parcluster('local'), 24)

tmp = rng;
seed = tmp.Seed;

%delete(gcp('nocreate')); error('debuggin...')

nSub = 89;
nFolds = 10;

spmd(3)
    tmp = cvpartition(nSub, 'KFold', nFolds);
    x = find(tmp.test(1)); % extract validation subject indices for fold 1
end

for ii = 1:3
    testSubRep(ii,:) = x{ii};
end

clear x tmp
delete(gcp('nocreate'))

tstamp = datestr(now, 'dd-mm-yyyy_HHMM');
save(['cvPart_', tstamp, '.mat'])

testSubRep

disp DONE