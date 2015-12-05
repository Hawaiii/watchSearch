run('/Users/hawaiii/Developer/vlfeat-0.9.20/toolbox/vl_setup');
% 
% % Extract HOG from images and save it to HOGWatch.mat and HOGnonWatch.mat
% 
% rotatedir = '../../data/AmazonWatchCropped/';
% % rotatedir = '../../data/AmazonWatchSquareRotated/';
% imagefiles = dir([rotatedir '*.jpg']);
% CURSIZE = 160;
% IMSIZE = 128;
% nfiles = length(imagefiles);    % Number of files found
% % HOGWatch = zeros(nfiles,8100);
% VLHOGWatch = zeros(nfiles,16*16*31);
% for ii=1:nfiles
%     currentfilename = imagefiles(ii).name;
% %     im = im2double(imread([rotatedir currentfilename]));
% %     HoG = extractHOGFeatures(im);
%     im = im2single(imread([rotatedir currentfilename]));
%     if size(im,1) ~= CURSIZE || size(im,2) ~= CURSIZE
%         currentfilename
%         continue;
%     end
%     window = randi(CURSIZE-IMSIZE+1, 1, 2);
%     HoG = vl_hog(im(window(1):window(1)+IMSIZE-1, window(2):window(2)+IMSIZE-1,:),8);
%     VLHOGWatch(ii,:) = HoG(:);
%     if mod(ii, 1000) == 0
%         ii
%     end
% end
% save('VLHOGWatch.mat', 'VLHOGWatch','-v7.3');

%%
nonwatchdir1 = '../../data/mineNeg/';
nonwatchdir2 = '../../data/new_background/';

imagefiles = dir([nonwatchdir1 '*.jpg']);
% nfiles = min(3*nfiles,length(imagefiles));
nfiles = length(imagefiles);
VLHOGnonWatch = zeros(nfiles, 16*16*31);
for jj=1:nfiles
    currentfilename = imagefiles(jj).name;
    im = im2single(imread([nonwatchdir1 currentfilename]));
    HoG = vl_hog(im,8);
    VLHOGnonWatch(jj,:) = HoG(:);
    if mod(jj, 1000) == 0
        jj
    end
end

imagefiles = dir([nonwatchdir2 '*.jpg']);
nfiles = 10000;
VLHOGnonWatch = vertcat(zeros(nfiles, 16*16*31), VLHOGnonWatch);
for jj=1:nfiles
    currentfilename = imagefiles(jj).name;
    im = im2single(imread([nonwatchdir2 currentfilename]));
    HoG = vl_hog(im,8);
    VLHOGnonWatch(jj,:) = HoG(:);
    if mod(jj, 1000) == 0
        jj
    end
end
save('VLHOGnonWatch.mat', 'VLHOGnonWatch','-v7.3');
'DONE'