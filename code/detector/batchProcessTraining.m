filedir = '../../data/AmazonWatchClean/';
imagefiles = dir([filedir '*.jpg']);
nfiles = length(imagefiles); 
for ii=1:nfiles
    currentfilename = imagefiles(ii).name;
%     im = im2single(imread([filedir currentfilename]));
%     HoG = vl_hog(im,8);
%     VLHOGWatch(ii,:) = HoG(:);
    dial = getClockDial(watchImgName)
end
save('VLHOGWatch.mat', 'VLHOGWatch','-v7.3');