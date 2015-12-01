function color_hist = ColorHist(input_image)
hsv_image = rgb2hsv(input_image);
h_bin = 30;
s_bin = 30;
h_hist = imhist(hsv_image(:,:,1),h_bin);
h_hist(1) = [];
h_hist = (h_hist - min(h_hist))/(max(h_hist) - min(h_hist));
s_hist = imhist(hsv_image(:,:,2),s_bin);
s_hist = (s_hist - min(s_hist))/(max(s_hist) - min(s_hist));
s_hist(1) = [];
color_hist = [h_hist',s_hist'];
end