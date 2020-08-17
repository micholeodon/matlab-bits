function jobInfo = getJobInfo()

% Get job ID
jobID_s = getenv('SLURM_ARRAY_TASK_ID');
nJobs_s = getenv('SLURM_ARRAY_TASK_COUNT');

if(isempty(jobID_s))
    jobID_s = '1';
end
jobInfo.jobID = str2double(jobID_s);

if(isempty(nJobs_s))
    nJobs_s = '1';
end
jobInfo.nJobs = str2double(nJobs_s);