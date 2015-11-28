function sift_feature = GenSIFT(input_image)

if size(input_image,3) ~= 1
    input_image = single(rgb2gray(input_image)) ;
end

if isempty(strfind(path,'vlfeat-0.9.20'))
    vlfeat_root = ['vlfeat-0.9.20'];
    run([vlfeat_root,'/toolbox/vl_setup']);
end

[f,sift_feature] = vl_sift(input_image,'EdgeThresh',5,'PeakThresh',10) ;
    
visualize_params = 0;
if visualize_params
    figure(1);clf
    image(input_image); hold on
    h1 = vl_plotframe(f) ;
    set(h1,'color','y','linewidth',3);hold off
end

sift_feature = double(sift_feature');
end