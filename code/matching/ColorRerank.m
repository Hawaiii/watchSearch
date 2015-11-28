function rerank_index = ColorRerank(rank_index, color_hist, input_image, k)

candi_hist = color_hist(rank_index,:);
input_color_hist = ColorHist(input_image);
rerank_score = sum(abs(repmat(input_color_hist, size(candi_hist,1),1) - candi_hist).^2,2);
[~, sorted_index] = sort(rerank_score, 'ascend');
rerank_index = rank_index(sorted_index(1:k));
    

end