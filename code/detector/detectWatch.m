function [x0, y0, width, height] = detectWatch(im, classifier)
% Use trained classifier to detect watches in images
% Return position of watch in image (in the box y0:y0+height, x0:x0+width),
% or [-1 -1 -1 -1] if not found.

xstep = 8;
ystep = 8;
patchSize = 128;
resizeScale = 0.8;

x0 =-1; y0 =-1; width=-1; height=-1;

bestdist = 0;

imdim = min(size(im,2), size(im,1));
downsize = 1;
while imdim >= patchSize
    % Make sliding window
    for x = 1:xstep:size(im,2)-patchSize
       for y = 1:ystep:size(im,1)-patchSize 
        % Extract HOG feature of the image
        hog = reshape(vl_hog(im(y:y+patchSize, x:x+patchSize,:),8),1,[]);
        label = predict(classifier, hog);
        if label == 1
            dist = hog*classifier.Beta/(classifier.Beta'*classifier.Beta);
            if dist > bestdist
                x0 = x;
                y0 = y;
                width = patchSize*downsize;
                height = patchSize*downsize;
                bestdist = dist;
            end
        end
       end
    end
    
    im = imresize(im, resizeScale);
    downsize = downsize/resizeScale;
    imdim = min(size(im,2), size(im,1));
end

end