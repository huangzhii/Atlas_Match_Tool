#09/02/2017 Jeremy Zhi Huang
flirt -in ./glasser_MNI.nii.gz -ref ./shen_1mm_268_parcellation.nii.gz -out ./glasser_MNI_registered.nii.gz -dof 6 -interp nearestneighbour

flirt -in ./Yeo2011_7Networks_MNI152_FreeSurferConformed1mm_LiberalMask.nii.gz -ref ./shen_1mm_268_parcellation.nii.gz -out ./Yeo2011_7Networks_MNI152_FreeSurferConformed1mm_LiberalMask_registered.nii.gz -dof 6 -interp nearestneighbour

flirt -in ./Yeo2011_17Networks_MNI152_FreeSurferConformed1mm_LiberalMask.nii.gz -ref ./shen_1mm_268_parcellation.nii.gz -out ./Yeo2011_17Networks_MNI152_FreeSurferConformed1mm_LiberalMask_registered.nii.gz -dof 6 -interp nearestneighbour

