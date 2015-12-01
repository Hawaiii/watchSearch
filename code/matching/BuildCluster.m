function BuildCluster

% image_folder_path = 'data_small/';
image_folder_path = 'AmazonWatchSquare/';
% image_folder_path = 'watchSmall/';
file_name = dir(image_folder_path);
curr_index = 0;
SIFT_feature = [];
image_index = [];
num_of_word_in_document = [];
num_of_layers = 9;
empty_image = 0;
color_hist = [];
for j = 1:size(file_name,1)
    if length(file_name(j).name) > 3 && strcmp(file_name(j).name(end-2:end),'jpg')
        curr_index = curr_index + 1;
        input_image = imread([image_folder_path,'/',file_name(j).name]);
        gray_image = single(rgb2gray(input_image));
        sift_feature = GenSIFT(gray_image);
        SIFT_feature = [SIFT_feature;sift_feature];
        if (size(sift_feature,1) == 0)
            empty_image = empty_image + 1;
            display([num2str(empty_image), ' no sift feature found']);
        end
        image_name{curr_index} = file_name(j).name;
        color_hist = [color_hist;ColorHist(input_image)];

        image_index = [image_index;repmat(curr_index, size(sift_feature,1),1)];
        num_of_word_in_document = [num_of_word_in_document;size(sift_feature,1)];
    end
end

[tree_center, link_relation, word_index] = ClusterSIFT(SIFT_feature, image_index, num_of_layers);
tf_idf = TfIdfWeighting(word_index, num_of_word_in_document);
for i = 1:size(word_index,1)
    word_index{i} = unique(word_index{i});
end
    
save('cluster_data.mat', 'tree_center', 'link_relation', 'word_index','tf_idf','image_name','color_hist');
end
