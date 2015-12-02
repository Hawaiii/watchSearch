run('/Users/hawaiii/Developer/vlfeat-0.9.20/toolbox/vl_setup');

% Extract HOG from images and save it to HOGWatch.mat and HOGnonWatch.mat

rotatedir = '../../data/AmazonWatchCropped/';
% rotatedir = '../../data/AmazonWatchSquareRotated/';
imagefiles = dir([rotatedir '*.jpg']);
nfiles = length(imagefiles);    % Number of files found
% HOGWatch = zeros(nfiles,8100);
VLHOGWatch = zeros(nfiles,16*16*31);
for ii=1:nfiles
    currentfilename = imagefiles(ii).name;
%     im = im2double(imread([rotatedir currentfilename]));
%     HoG = extractHOGFeatures(im);
    im = im2single(imread([rotatedir currentfilename]));
    if size(im,1) ~= 128 || size(im,2) ~= 128
        currentfilename
        continue;
    end
    HoG = vl_hog(im,8);
    VLHOGWatch(ii,:) = HoG(:);
    if mod(ii, 1000) == 0
        ii
    end
end
save('VLHOGWatch.mat', 'VLHOGWatch','-v7.3');

%%
nonwatchdir = '../../data/new_background/';
imagefiles = dir([nonwatchdir '*.jpg']);
nfiles = min(nfiles,length(imagefiles));
% HOGnonWatch = zeros(nfiles, 8100);
VLHOGnonWatch = zeros(nfiles, 16*16*31);
for jj=1:nfiles
    currentfilename = imagefiles(jj).name;
%     im = im2double(imread([nonwatchdir currentfilename]));
%     HoG = extractHOGFeatures(im);
    im = im2single(imread([nonwatchdir currentfilename]));
    HoG = vl_hog(im,8);
    VLHOGnonWatch(jj,:) = HoG(:);
    if mod(jj, 1000) == 0
        jj
    end
end
save('VLHOGnonWatch.mat', 'VLHOGnonWatch','-v7.3');
'DONE'