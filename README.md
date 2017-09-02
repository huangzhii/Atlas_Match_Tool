09/02/2017 Version 1.0
Jeremy Zhi Huang

In data folder:
All Atlas are already done dof6 rigid registration to Shen_1mm_268_parcellation.nii.gz with interpolation method nearest neighbour.

Input: *Atlas_A* (m nodes), *Atlas_B* (n nodes)
Output: nxm matrix Dice coefficient map, A & B ROI to ROI Mapping csv file, sorted descending (Amap2B.csv, Bmap2A.csv).

Example outputs:

1. Shen 2015 (268 nodes) VS Glasser (360 nodes)
![shen268VSGlasser360](https://github.com/huangzhii/Atlas_Match_Tool/blob/master/sample_results/shen268VSGlasser360.png)


2. Shen 2015 (268 nodes) VS Shen 2013 (278 nodes)
![shen268VSshen278](https://github.com/huangzhii/Atlas_Match_Tool/blob/master/sample_results/shen268VSshen278.png)


3. Yeo 17 (17 nodes) VS Shen 2015 (268 nodes)
![yeo17VSshen268](https://github.com/huangzhii/Atlas_Match_Tool/blob/master/sample_results/yeo17VSshen268.png)


4. Yeo 7 (7 nodes) VS Yeo 17 (17 nodes)
![yeo7VSyeo17](https://github.com/huangzhii/Atlas_Match_Tool/blob/master/sample_results/yeo7VSyeo17.png)
