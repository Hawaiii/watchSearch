run('/Users/hawaiii/Developer/vlfeat-0.9.20/toolbox/vl_setup');

% Testing detector on rotated images
load('watchSVM.mat');
truepos = 0;
trueneg = 0;
falsepos = 0;
falseneg = 0;

filedir = '../../data/AmazonWatchSquareRotated/';
% filedir = '../../data/google_watches/';
imagefiles = dir([filedir '*.jpg']);
nfiles = length(imagefiles);    % Number of files found

for ii = 1:nfiles
    currentfilename = imagefiles(ii).name;
    % Extract HOG
    im = im2single(imread([filedir currentfilename]));
    hog = reshape(vl_hog(im,8),1,[]);
    
    % Make Prediction
    [confidence] = HOGContainsWatch(hog, svm)
    
    if confidence ~= -1
        truepos = truepos + 1;
    else
        falseneg = falseneg + 1;            
    end
end
truepos
trueneg
falsepos
falseneg

%         if  confidence == -1
%             trueneg = trueneg + 1;
%         else
%             falsepos = falsepos + 1;
%         end

