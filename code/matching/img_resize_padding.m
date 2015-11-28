function output_image = img_resize_padding(input_image, re_scale)
%input_image - [m x n x 3] image
%re_scale - scale factor, such as 128
[m,n,k] = size(input_image);
if m > n
    left_padding_edge = round((m - n) / 2);
    right_padding_edge = m - n - left_padding_edge;
    input_image = [255 * ones(m,left_padding_edge,k), input_image, 255 * ones(m,right_padding_edge,k)];
elseif m < n
    up_padding_edge = round((n - m) / 2);
    down_padding_edge = n - up_padding_edge;
    input_image = [255 * ones(up_padding_edge, n, k); input_image; 255 * ones(down_padding_edge, n, k)];
end
output_image = imresize(input_image, [re_scale,re_scale]);
end