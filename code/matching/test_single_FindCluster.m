function output_name = test_single_FindCluster(test_image_name)
if nargin < 1
    test_image_name = 'test-1.jpg';
    % test_image_name = 'SEIKO-SNAD88P1-3_cropped.jpg';
    % test_image_name = 'tissot_prs516_watch_on_hand.jpg';
    % test_image_name = 'nursingschoolchecklist_watch.jpg';
end

load('cluster_data.mat');
image_folder_path = '../../data/AmazonWatchSquare/';

input_image = imread(test_image_name);
resized_image = img_resize_padding(input_image, 128);
load('watch_mask.mat');
non_white = repmat(~allwhite,1,1,3);
resized_image(non_white) = 255;
k1 = 50;
rank_index = FindCluster(resized_image, link_relation, tf_idf, tree_center, word_index,k1);
k2 = 11;
rerank_index = ColorRerank(rank_index, color_hist, resized_image, k2);
res_image = cell(k2+1,1);
res_image{1} = resized_image;
output_name = image_name(rerank_index);
for i = 1:k2
    res_image{i+1} = imread([image_folder_path,image_name{rank_index(i)}]);
end

addpath(genpath('imdisp'))
imdisp(res_image);

end
