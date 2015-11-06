function [cluster_center, word_index] = ClusterSIFT(SIFT_feature, image_index, num_of_cluster)
% INPUT
%   .SIFT_feature - [n x m]. n is the number of keypoints.
%   .image_index - [n x 1]. the file index for each keypoint.
%   .num_of_cluster - k, a number indicates the number of cluster
% OUTPUT
%   .cluster_center - [k x m] matrix
%   .word_index - [k x 1] cell. Each cell contains a list of file index
%                 corresponding to the cluster_center
cluster_index = clusterdata(SIFT_feature,'distance','euclidean', 'linkage','average','maxclust',num_of_cluster);
cluster_center = zeros(num_of_cluster,size(SIFT_feature,2));
word_index =cell(num_of_cluster,1);
for i = 1: num_of_cluster
    cluster_center(i,:) = median(SIFT_feature(cluster_index == i,:));
    word_index{i} = image_index(cluster_index == i);
end

end