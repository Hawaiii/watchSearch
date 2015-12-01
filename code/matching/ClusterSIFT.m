function [tree_center, link_relation, word_index] = ClusterSIFT(SIFT_feature, image_index, num_of_layers)
% INPUT
%   .SIFT_feature - [n x m]. n is the number of keypoints.
%   .image_index - [n x 1]. the file index for each keypoint.
%   .num_of_cluster - k, a number indicates the number of cluster
% OUTPUT
%   .cluster_center - [k x m] matrix
%   .word_index - [k x 1] cell. Each cell contains a list of file index
%                 corresponding to the cluster_center
if (~isa(SIFT_feature,'single'))
    SIFT_feature = single(SIFT_feature);
end
% Sequences = multialignread('aagag.aln');
% distances = pdist(SIFT_feature);
% tree = seqlinkage(distances);

% hi_tree = linkage(SIFT_feature,'average');
% PhyloTree = seqlinkage(hi_tree(:,3));
% for i = 1:num_of_layers
%     
%     
% end

num_of_clusters = 2 ^ (num_of_layers-1);
rng default;
cluster_index = kmeans(SIFT_feature,num_of_clusters);
% c = cluster(hi_tree,'maxclust',4);
% cluster_index = clusterdata(SIFT_feature,'distance','euclidean', 'linkage','average','maxclust',num_of_clusters);
cluster_center = zeros(num_of_clusters,size(SIFT_feature,2));
word_index = cell(num_of_clusters,1);
for i = 1: num_of_clusters
    cluster_center(i,:) = mean(SIFT_feature(cluster_index == i,:),1);
    word_index{i} = image_index(cluster_index == i);
end

hi_tree = linkage(cluster_center,'average');

max_tree_num = hi_tree(end,2);
tree_center = zeros(max_tree_num,size(SIFT_feature,2));
tree_center(1:num_of_clusters,:) = cluster_center;

for tree_index = num_of_clusters + 1:max_tree_num
    child_index = tree_index - num_of_clusters;
    tree_center(tree_index,:) = (tree_center(hi_tree(child_index,1),:) + tree_center(hi_tree(child_index,2),:))/2;
end

link_relation = hi_tree(:,1:2);

end