function test_FindCluster
load('cluster_data.mat');
% image_folder_path = 'data_small/';
% image_folder_path = 'AmazonWatchSquare/';
image_folder_path = 'watchSmall/';

file_name = dir(image_folder_path);
count = 0;
acc_count = 0;
for i = 1:size(file_name,1)
    if length(file_name(i).name) > 3 && strcmp(file_name(i).name(end-2:end),'jpg')
        count = count + 1;
        input_image = single(rgb2gray(imread([image_folder_path,'/',file_name(i).name])));
        rank_index = FindCluster(input_image, link_relation, tf_idf, tree_center, word_index, count);
        if (rank_index == count) acc_count = acc_count + 1; end
        display(['count: ',num2str(count),' ', num2str(rank_index)])
    end
end

acc_count

end

