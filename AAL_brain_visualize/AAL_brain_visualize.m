%% Select region from roi number or roi label
clear; close all; clc;

% SETUP FIELDTRIP PATH
fieldtripPath       = '/home/michak/matlab_conf_plug_lic/fieldtrip-20171127/';
addpath(fieldtripPath);
ft_defaults;

% (!!!) Set this ...
roi_label = 'Caudate_R';
% ... or this :
roi_number = 21;




disp('Reading MRI ...')
mrifile = [fieldtripPath 'template/anatomy/single_subj_T1.nii'];
mri = ft_read_mri(mrifile);
mri.coordsys = 'mni'; % to prevent manual fixing of coordsys
%ft_sourceplot([],mri)


% Get atlas
disp('Interpolate to atlas ...')
atlasDir            = [fieldtripPath 'template/atlas/aal/ROI_MNI_V4.nii']; 
atlas               = ft_read_atlas(atlasDir);

% choose label or number (prompt)
o1 = 'LABEL';
o2 = 'NUMBER';
choice = questdlg('Highlight ROI according to ...  ', '_', o1, o2, o1);
% Handle response
switch choice
    case o1
        roiName = roi_label;
    case o2
        roiName = atlas.tissuelabel(roi_number);
end

% grab correct ROI index
roiIndex            = find(ismember(atlas.tissuelabel, roiName));
atlas.selROIvoxels  = double(atlas.tissue == roiIndex);
cfg = [];
cfg.parameter       = 'selROIvoxels';
cfg.method          = 'nearest';
chosenROI           = ft_sourceinterpolate(cfg, atlas, mri);


% preparing pictures
figTitle = ['Selected ROI: ' roiName];
disp('Creating surface view ...')
cfg                     = [];
cfg.method              = 'surface'; % this is important to prevent black spots !
cfg.projmethod          = 'project'; % this is important to prevent black spots !
cfg.projvec             = [0 5]; 
cfg.surfdownsample      = 4; % maybe this smooth things up? Yes.
cfg.projcomb            = 'max'; % this helps spread color more evenly
cfg.renderer            = 'zbuffer';
cfg.camlight            = 'yes';
% VIEW 1 - both
% Choose one surface file
cfg.surffile = [fieldtripPath 'template/anatomy/surface_white_both.mat']; 
cfg.locationcoordinates = 'voxel';
%cfg.cmap                = mycolormap(1:20,:); 
cfg.cmap                = [[1,1,1];[1 0 0]] % color map
cfg.funcolormap         = cfg.cmap;
cfg.funparameter        = 'selROIvoxels';
%cfg.funcolorlim         = [0 20];
cfg.atlas               = atlas;
ft_sourceplot(cfg, chosenROI)
title(figTitle,'Interpreter','none')


% VIEW 2 - left
% Choose one surface file
cfg.surffile = [fieldtripPath 'template/anatomy/surface_white_left.mat']; 
ft_sourceplot(cfg, chosenROI)
title(figTitle,'Interpreter','none')

% VIEW 3 - right
% Choose one surface file
cfg.surffile = [fieldtripPath 'template/anatomy/surface_white_right.mat']; 
ft_sourceplot(cfg, chosenROI)
title(figTitle,'Interpreter','none')

% VIEW 4 - Slice
disp('Creating slice view ...')
cfg                     = [];
cfg.method              = 'slice';
cfg.nslices             = 20;
cfg.slicerange          = [1 81];
cfg.locationcoordinates = 'voxel';
cfg.location            = [41,52,49]; % some custom typical location (in voxel, not cm) !
%cfg.cmap                = mycolormap(1:20,:); % color according to number of ROI
cfg.cmap                = [[0,0,0]; [1 0 0]]; % color map
cfg.funcolormap         = cfg.cmap;
cfg.funparameter        = 'selROIvoxels';
%cfg.funcolorlim         = [0 20];
cfg.atlas               = atlas;
ft_sourceplot(cfg, chosenROI)
title(figTitle,'Interpreter','none')

% -----------------------------------------------

%% Ortho view of the atlas

cfg                     = [];
cfg.method              = 'ortho';
%cfg.locationcoordinates = 'voxel'
cfg.location            = [41,52,49];
cfg.cmap                = jet(12);
cfg.cmap          = [[0,0,0]; cfg.cmap]
cfg.funcolormap         = cfg.cmap;
cfg.funparameter        = 'tissue';
%cfg.atlas               = atlas;
ft_sourceplot(cfg, atlas)
