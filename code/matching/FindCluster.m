function doc_index = FindCluster(input_image, link_relation, tf_idf, tree_center, word_index, k)

if nargin < 6
    k = 1;
end
% num_of_document = size(word_index,1);
sift_feature = GenSIFT(input_image);
num_of_curr_word = size(sift_feature,1);
min_cluster_num = size(word_index,1);
num_of_document = size(tf_idf,2);
num_of_word = size(tf_idf,1);
word_vector = zeros(1,num_of_word);
for i = 1:size(sift_feature,1)
    center_dist = pdist([sift_feature(i,:);tree_center(1:min_cluster_num,:)]);
    [~, curr_index] = min(center_dist(1:min_cluster_num));
    word_vector(curr_index) = word_vector(curr_index) + 1;
end

t = zeros(1, num_of_word);
for i = 1:num_of_word
    t(i) = word_vector(i)/num_of_curr_word * log(num_of_document / length(word_index{i}));
end

score = zeros(num_of_document,1);

for docu_index = 1:num_of_document
    tf_norm = norm(tf_idf(:,docu_index));
    if (tf_norm == 0) continue; end
    score(docu_index) =  t * tf_idf(:,docu_index)/(tf_norm * norm(t));
end
[~,rank_index] = sort(score,'descend');
doc_index = rank_index([1:k]);
    

end