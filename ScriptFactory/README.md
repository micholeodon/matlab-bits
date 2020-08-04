# ScriptFactory

This is a program that can create different versions (a.k.a. *releases*) of data analysis workflows using common template and data.

## Usage

1. Put input data inside `data` directory. There should be the input data common to all releases. Output data will be generated into separate directories inside specific releases `output` directories.
1. Edit `gen_scripts/S1_MAIN.m` as well as other `.m` files in that directory (you can also add there as many `.m` files as you wish). Use input data from the `data` directory. 
1. Test and modify your program there until you are satified.
1. Edit `RELEASE.sh` file at following lines:
   1. Line 13: Edit `release_name` variable. This will be the name of your output version of your release.
   1. Lines from 70 till `EOF` word: Put any relevant info about your release there.
1. Run `RELEASE.sh` script to create a new release of the workflow.


## What I have learnt?

  * Mixing `sh` with matlab code
  * Modular programming apporach
  * `sh`: interacting with the user (question-answer prompt)
