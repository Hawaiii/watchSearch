function HierCluster

% load fisheriris
% % rng default;  % For reproducibility
% X = [1 2;2.5 4.5;2 2;4 1.5;...
%     4 2.5];

% Y = pdist(X);
% squareform(Y);
% makes more sense with average because we need to cluster the whole data
% Z = linkage(meas,'average','euclidean');
load fisheriris

Z = linkage(meas,'average','euclidean');
% inconsistent(Z)
T = clusterdata(meas,'criterion', 'distance', 'distance','euclidean', 'linkage','average','maxclust',3);
dendrogram(Z)

end