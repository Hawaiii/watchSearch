function count = saveWatchSlidingWindow(im, classifier, count, writeFolderName)
% Use trained classifier to detect watches in images
% Return position of watch in image (in the box y0:y0+height, x0:x0+width),
% or [-1 -1 -1 -1] if not found.

xstep = 16;
ystep = 16;
patchSize = 128;
resizeScale = 0.7;
% EDGETHRES = 200;
EDGETHRES = 0;

if size(im,3) > 1
    grayim = rgb2gray(im);
else
    grayim = im;
end
edgeim = edge(grayim);

x0 =-1; y0 =-1; width=-1; height=-1;

bestdist = 0;

imdim = min(size(im,2), size(im,1));
downsize = 1;
while imdim >= patchSize
    % Make sliding window
    for x = 1:xstep:size(im,2)-patchSize
       for y = 1:ystep:size(im,1)-patchSize
        x0_ = x*downsize;
        y0_ = y*downsize;
        width_ = patchSize*downsize;
        height_ = patchSize*downsize;
        if sum(sum(edgeim(max(1, round(y0_)):min(size(edgeim,1), round(y0_+height_-1)),...
                max(1,round(x0_)):min(size(edgeim,2), round(x0_+width_-1))))) < EDGETHRES*downsize^2;
            continue;
        end
        % Extract HOG feature of the image
        tosave = im(y:min(y+patchSize-1, size(im,1)), x:min(x+patchSize-1, size(im,2)),:);
        if size(tosave, 1) == 128 && size(tosave,2) == 128
            hog = reshape(vl_hog(tosave,8),1,[]);
            label = predict(classifier, hog);
            if label == 1
                dist = hog*classifier.Beta+classifier.Bias;
                imwrite(tosave, ...
                [writeFolderName num2str(count) '.jpg']);
                count = count + 1;
            end
        end
       end
    end
    
    im = imresize(im, resizeScale);
    downsize = downsize/resizeScale;
    imdim = min(size(im,2), size(im,1));
end
% bestdist
end