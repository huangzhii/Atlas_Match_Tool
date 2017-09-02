function  atlas_match( pathA, pathB )
    % ADDME  Help on atlas_match
    %   User should input 2 nifti files which are registered together in advance.
    %   09/01/2017 Jeremy Zhi Huang
    addpath('./toolbox_matlab_nifti/');
    ans1 = MRIread(pathA);
    m1 = ans1.vol;
    ans2 = MRIread(pathB);
    m2 = ans2.vol;

    %% Difference Compare
    unique1 = unique(m1);
    unique2 = unique(m2);
    unique1 = unique1(2:end);
    unique2 = unique2(2:end);

    AandB = zeros(length(unique2), length(unique1));
    MaxLength = max(length(unique2), length(unique1));
    MinLength = min(length(unique2), length(unique1));

    tic
    for i = 1:MaxLength
        m2_roi = (m2==i);
        for j=1:MinLength
            m1_roi = (m1==j);
            m2_and_m1 = m1_roi .* m2_roi;
            % Dice coefficient
            AandB(i,j) = sum(m2_and_m1(:) > 0)/(sum(m1_roi(:)) + sum(m2_roi(:)));
        end
        fprintf(['Progress: ' num2str(i/MaxLength*100) '%% ...\n']);
    end
    toc

    save('AandB_origin.mat', 'AandB');

    %% Reordering (Row Column Permutation)

    AandB = load('AandB_origin.mat');
    AandB = AandB.AandB;
    AandB_origin = AandB;
    AandB = AandB ./ max(max(AandB));imshow(AandB);
    AandB_rowpermu = AandB;

    atlas1NodeOrder = 1:length(unique1);
    atlas1NodeOrder2 = 1:length(unique1);
    atlas2NodeOrder = 1:length(unique2);
    atlas2NodeOrder2 = 1:length(unique2);

    % Row Permutation
    for i = 1:length(unique2)
        [M,I] = max(AandB(:));
        [I_row, I_col] = ind2sub(size(AandB),I);
        fprintf(['(' int2str(I_row) ', ' int2str(I_col) ') is the ' int2str(i) ...
            '''th maximum value over entire matrix. Move corresponding row ' ...
            int2str(I_row) ' to row ' int2str(i) '.\n']);
        AandB_rowpermu(i,:) = AandB(I_row,:);
        atlas2NodeOrder2(i) = atlas2NodeOrder(I_row);
        AandB(I_row, :) = -1; % Remove entire row from candidate pool
        imshow(AandB_rowpermu);
    end

    % Col Permutation
    AandB_colpermu = AandB_rowpermu;
    for i = 1:length(unique1)
        [M,I] = max(AandB_rowpermu(i,:));
        fprintf([int2str(i) '''th row''s maximum value: ' num2str(M) ...
            ', corresponding column: ' int2str(I) ', move to the left.\n']);
        AandB_colpermu(:,i) = AandB_rowpermu(:,I);
        AandB_rowpermu(:,I) = -1; % Remove entire col from candidate pool
        atlas1NodeOrder2(i) = atlas1NodeOrder(I);
        imshow(AandB_colpermu);
    end

    Map = AandB_colpermu;
    imshow(Map);
    xlabel('Atlas A');
    ylabel('Atlas B');
    title('Similarity Map ("Dice Coefficient")');
    set(gca,'xaxisLocation','top');

    %% Heatmap
    imagesc(Map);
    colormap('default');
    xlabel('Atlas A');
    ylabel('Atlas B');
    title('Similarity Map ("Dice Coefficient")');
    colorbar;
    set(gca,'xaxisLocation','top');
    set(gca,'xtickLabel', atlas1NodeOrder2);
    set(gca,'ytickLabel', atlas2NodeOrder2);
    h=gca;
    h.XTickLabelRotation = 60;
    daspect([1 1 1]);

    %% Generate comparison
    Amap2B = {'Atlas_A_index' 'Atlas_B_index' 'Dice_Coefficient'};
    for i = 1:length(unique1)
        [M, I] = max(Map(:,i));
        col = {atlas1NodeOrder2(i) atlas2NodeOrder2(I) M};
        Amap2B = [Amap2B; col];
    end
    cell2csv('./Amap2B.csv',Amap2B,',');
    
    Bmap2A = {'Atlas_B_index' 'Atlas_A_index' 'Dice_Coefficient'};
    for i = 1:length(unique2)
        [M, I] = max(Map(i,:));
        row = {atlas2NodeOrder2(i) atlas1NodeOrder2(I) M};
        Bmap2A = [Bmap2A; row];
    end
    cell2csv('./Bmap2A.csv',Bmap2A,',');
end

