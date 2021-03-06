clear; %clc;

%rng(123)
%rng shuffle

%run init_parallel_env % moze tu jest blad? ponizej ekwiwalent tego
%kodu bez czekania na licencje
%parpool(parcluster('local'), 24)

%disp('Before rng shuffle:')
%tmp = rng;
%seed = tmp.Seed;
%disp(seed)
%rng shuffle
%disp('After rng shuffle:')
%tmp = rng;
%seed = tmp.Seed;
%disp(seed)

%delete(gcp('nocreate')); error('debuggin...')

nSub = 89;
nFolds = 10;

rng shuffle
tmp = rng;
baseSeed = tmp.Seed;
jobInfo = getJobInfo(); 

spmd(3)
    % set individual stream
    s = RandStream.create('mrg32k3a', ...
                          'NumStreams', numlabs, ...
                          'Seed', baseSeed+jobInfo.jobID, ...
                          'StreamIndices', labindex);
    RandStream.setGlobalStream(s);
    
    tmp = rng;
    disp(['LAB ', num2str(labindex), ' seed after shuffle: ', num2str(tmp.Seed)])
    tmp = cvpartition(nSub, 'KFold', nFolds);
    x = find(tmp.test(1)); % extract validation subject indices for fold 1
end

for ii = 1:3
    testSubRep(ii,:) = x{ii};
end

clear x tmp s
delete(gcp('nocreate'))

tstamp = datestr(now, 'dd-mm-yyyy_HHMM');
save(['cvPart_', tstamp, '.mat'])

testSubRep

disp DONE