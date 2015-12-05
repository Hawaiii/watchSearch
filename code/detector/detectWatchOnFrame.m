function [x0, y0, width, height] = detectWatchOnFrame(im, svm)
%        [x0, y0, width, height] = detectWatchSlidingWindow(im, svm);

%        if x0 <= 0 || y0 <= 0
%            watchSeg = [];
%        else
%         watchSeg = frame(y0:y0+height, x0:x0+width,:);
%        end

% Copying from detectWatchSlidingWindow
% Use trained classifier to detect watches in images
% Return position of watch in image (in the box y0:y0+height, x0:x0+width),
% or [-1 -1 -1 -1] if not found.

xstep = 16;
ystep = 16;
patchSize = 128;
resizeScale = 0.7;
EDGETHRES = 200;

if size(im,3) > 1
    grayim = rgb2gray(im);
else
    grayim = im;
end
edgeim = edge(grayim);

x0 =-1; y0 =-1; width=-1; height=-1;

bestdist = 0.33;

imdim = min(size(im,2), size(im,1));
downsize = 1;
while imdim >= patchSize
    % Make sliding window
    for x = 1:xstep:size(im,2)-patchSize
       for y = 1:ystep:size(im,1)-patchSize
        x0_ = round(x*downsize);
        y0_ = round(y*downsize);
        width_ = round(patchSize*downsize);
        height_ = round(patchSize*downsize);
        % Extract HOG feature of the image
        x1 = min(x+patchSize-1, size(im,2));
        y1 = min(y+patchSize-1, size(im,1));
        if y1-y+1 == patchSize && x1-x+1 == patchSize
            if sum(sum( edgeim(max(1, y0_):min(size(edgeim,1), y0_+height_-1),...
                max(1,x0_):min(size(edgeim,2), x0_+width_-1)) )) < EDGETHRES*downsize^2;
                % ignore if too few edges inside
                continue;
            end
            hog = reshape(vl_hog(im(y:y1, x:x1,:),8),1,[]);
              dist = hog*classifier.Beta+classifier.Bias;
              if dist > bestdist
%                 imshow(im(y:min(y+patchSize, size(im,1)), x:min(x+patchSize, size(im,2)),:));
                    x0 = x0_;
                    y0 = y0_;
                    width = width_;
                    height = height_;
                    bestdist = dist;
              end
        end
       end
    end
    
    im = imresize(im, resizeScale);
    downsize = downsize/resizeScale;
    imdim = min(size(im,2), size(im,1));
end
bestdist
end
