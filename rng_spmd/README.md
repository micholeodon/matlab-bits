# rng_spmd

When one wants to guarantee certain properties of random numbers in MATLAB when working inside `spmd`/`parfor` block
default configuration is not always sufficient.

Despite recent work on setting (pseudo)random numbers generators (rng) properly it turned out that:
* there are two different rngs: 
  1. "Parallel rng" - one used inside `spmd` / `parfor` blocks 
  1. "Serial rng" - other used outside `spmd` / `parfor` blocks 
* by default (i.e. after opening new MATLAB session) rngs are set to seed=0 


I have ran series of experiments to learn how these random generators work and to solve my main problem:


*How to set rngs so running multiple jobs with spmd clusters produce unique results across workers, jobs and batch-runs?*

## What I have learnt? ##

  * how to control pseudorandom number generator inside serial code blocks
  * how to control pseudorandom number generator inside parallel code blocks
  * how to use `RandStream` to generate different streams of pseudorandom numbers


## EXPERIMENTS ##

Below there are short descriptions of these experiments, their results and conclusions.
Following items are provided for each of them: code, output file with workspace variables, logfiles from parallel computations.


### Experiment 1 ###
Running two times same script in one MATLAB sessions, `spmd` block. Default rng behavior.

**Observation**:
- each worker generate its own series of random numbers
- each time script is being run, same series of random numbers are produced

**Conclusion**:
- within single MATLAB session, each start of the `parpool` causes Parallel rng seed to reset to its default value


### Experiment 2 ###
Running two time same script in separate MATLAB session (through job scheduling system SLURM). Default rng behavior. 

**Observation**:
- each worker generate its own series of random numbers
- each time script is being run, same series of random numbers are produced

**Conclusion**:
- within single MATLAB session, each start of the `parpool` causes Parallel rng seed to reset to its default value
- running in separate MATLAB sessions did not change default values of the rng
- running in separate MATLAB sessions using job scheduling system did not change default values of the rng


### Experiment 3 ###
Same as Experiment 2, but putting rng shuffle outside `spmd` block.

**Observation**:
- each worker generate its own series of random numbers
- each time script is being ran, same series of random numbers are produced

**Conclusion**:
- setting of serial rng seed does not have influence on parallel rng


### Experiment 4 ###
"Digression". Generation of 5 normally distributed random numbers. Two different MATLAB sessions.

**Observation**:
- same random number series in each MATLAB session

**Conclusion**:
- each session reset serial rng seed to its default value


### Experiment 5 ###
Same as Experiment 2, but explicitly initializing parpool.

**Observation**:
- each worker generate its own series of random numbers
- each time script is being run, same series of random numbers are produced

**Conclusion**:
- explicit call to parpool does not change default behavior of the rngs


### Experiment 6 ###
Same as Experiment 5, but calling `rng shuffle` after initializing `parpool`.
- each worker generate its own series of random numbers
- each time script is being run, same series of random numbers are produced

**Conclusion**:
- adding `rng shuffle` did not change anything in comparison to Experiment 5


### Experiment 7 ###
Same as Experiment 2, but adding rng shuffle inside `spmd` block.

**Observation**:
- worker got same seed
- both workers produced same output

**Conclusion**:
- as long as each worker has same seed, they will produce same series of random numbers


### Experiment 8 ###
Same as Experiment 2, but used `RandStream` inside `spmd` block, assigning different stream to each worker, not intrusing to keep its default behavior.

**Observation**:
- each worker got separate stream of random number
- same streams of random numbers across different MATLAB sessions

**Conclusion**:
- creating `RandStream` (and assigning different stream to each worker) in its default behavior does not guarantee independence of random numbers across different MATLAB sessions


### Experiment 9 ###
Same as Experiment 8, but setting fixed seed. 

**Observation**:
- each worker got separate stream of random number
- same streams of random numbers across different MATLAB sessions

**Conclusion**:
- (taking into account Observation from Experiment 8): creating `RandStream` (and assigning different stream to each worker) without keeping seed different for each worker does not guarantee independence of random numbers across different MATLAB sessions

### Experiment 10 ###
Same as Experiment 8, but setting seed basing on time (`'shuffle'`).

**Observation**:
- each worker got separate stream of random number
- different streams of random numbers across different MATLAB sessions

**Conclusion**:
- creating `RandStream` (and assigning different stream to each worker) with 'shuffle' inside spmd block does guarantee independence of random numbers across different MATLAB sessions (as long as launched not more frequent than 1 second apart)

### Experiment 11 ###
Same as Experiment 10, but twin jobs lauched simultaneously.

**Observation**:
- each worker got separate stream of random number
- very similar seeds values across jobs in single run
- different streams of random numbers across jobs in single run
- different streams of random numbers across different runs of twin jobs
 
Conclusions:
- different streams of random numbers across jobs in single run was an effect of different seeds
- similar seeds values across jobs in single run signigies that there is a potential risk of jobs having accidentally same seed values which would lead to same series of random numbers in both jobs

### Experiment 12 ###
Same as Experiment 11. but added its own job identification number to each job seed.

**Observation**:
- each worker got separate stream of random number
- different seeds values across jobs in single run
- different streams of random numbers across jobs in single run
- different streams of random numbers across different runs of twin jobs
 
**Conclusion**:
- there is no problem with that approach as long as time distance between each run of multiple jobs is big, so their seeds
