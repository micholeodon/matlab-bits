% NOTE: This script is intended to be modified. 
% Final version (one of many) 
% should be released (tangled) to separate file!
%
% TYPICAL WORKFLOW:
% 1. Modify
% 2. Release
% 3. Test
% 4. Do 1-3 until you are satisfied
% 5. Release final version.

clear; close all; clc;

CFG.absolutepath = pwd;
CFG.list = {'01', '02', '03'};
CFG.list_ok = [1 2 3];
% CFG.input_data_f = ['..', '/data/ver1/']; % !!! UNCOMMENT FOR TESTING ONLY !
CFG.input_data_f = ['../../..', '/data/ver1/'];% !!! UNCOMMENT AFTER TESTS BEFORE RELEASING  !
CFG.input_data_n = 'sig_';
% CFG.output_data_f = './output_test/' % !!! UNCOMMENT FOR TESTING ONLY !
CFG.output_data_f = '../output/' % !!! UNCOMMENT AFTER TESTS BEFORE RELEASING  !
CFG.output_data_n = 'y_'

disp('Saving config ...')
save([CFG.output_data_f, 'CFG'], 'CFG')
disp 'Ok !'

disp ' --- CALCULATIONS ---'
for ss = CFG.list(CFG.list_ok)
    id = ss{1};
    disp(['Loading ' id '...'])
    load([CFG.input_data_f, CFG.input_data_n, id])
    
    disp 'Serious calculations ...'
    [t, y] = F_S1_Fun1(sig);
    
    disp 'Saving results ...'
    save([CFG.output_data_f, CFG.output_data_n, id], 't', 'y')
    
    disp 'Done !'
end
clearvars -EXCEPT CFG

disp '--- VISUALIZATION ---'
for ss = CFG.list(CFG.list_ok)
    id = ss{1};
    disp(['Loading ' id '...'])
    load([CFG.output_data_f, CFG.output_data_n, id])
    
    S_S1_Vis
    disp 'Done !'
end

disp '--- FINISHED. ---'


