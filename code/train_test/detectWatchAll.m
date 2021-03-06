run('/Users/hawaiii/Developer/vlfeat-0.9.20/toolbox/vl_setup');
addpath('../detector/')

% Load data from the small dataset
% filedir = '../../data/nonwatch/';
filedir = '../../data/camera_image/';
% filedir = '../../data/google/';
imagefiles = dir([filedir '*.jpg']);
nfiles = length(imagefiles);    % Number of files found

% Load classifier trained
load('watchSVM.mat');

for ii = 1:nfiles
    currentfilename = imagefiles(ii).name;
    im = im2single(imread([filedir currentfilename]));
    [x0, y0, width, height] = detectWatchSlidingWindow(im, svm);
    clf;imshow(im);
    if x0 ~= -1
%         imshow(im(y0:height+y0, x0:width+x0,:));
        hold on; rectangle('Position', [x0 y0 width height],'EdgeColor','yellow'); hold off;
    end
    pause
end