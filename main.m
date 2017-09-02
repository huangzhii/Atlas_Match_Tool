% 09/01/2017 Jeremy Zhi Huang

clc;close all;clear all;
addpath('./toolbox_matlab_nifti/');

% These data are registered to shen_1mm_268_parcellation
% with dof 6 flirt method, with interpolation nearest neighbour.
data1 = './data/shen_1mm_268_parcellation.nii.gz';
data2 = './data/fconn_atlas_150_1mm.nii';
data3 = './data/glasser_MNI_registered.nii.gz';
data4 = './data/Yeo2011_7Networks_MNI152_FreeSurferConformed1mm_LiberalMask_registered.nii.gz';
data5 = './data/Yeo2011_17Networks_MNI152_FreeSurferConformed1mm_LiberalMask_registered.nii.gz';

% Please make Atlas_B dimension larger than Atlas_A.
Atlas_A = data5;
Atlas_B = data1;

atlas_match( Atlas_A, Atlas_B );