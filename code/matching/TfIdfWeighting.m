function tf_idf = TfIdfWeighting(word_index, num_of_word_in_document)
num_of_word = size(word_index,1);
num_of_document = size(num_of_word_in_document,1);

tf_idf = zeros(num_of_word, num_of_document);
for i = 1:num_of_word
    doc_occurrance = unique(word_index{i});
    num_uniq_doc = length(doc_occurrance);
    for j = 1:num_uniq_doc
        curr_doc = doc_occurrance(j);
        tf_idf(i,curr_doc) = sum(word_index{i} == curr_doc)/num_of_word_in_document(curr_doc) * log(num_of_document/num_uniq_doc);
    end
end

end