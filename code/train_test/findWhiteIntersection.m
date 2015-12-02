% Find the pixels that are always white in the training data
filedir = '../../data/AmazonWatchCropped/';
imagefiles = dir([filedir '*.jpg']);
nfiles = length(imagefiles);    % Number of files found
allwhite = zeros(128,128);
for ii=1:nfiles
    currentfilename = imagefiles(ii).name;
    im = im2bw(imread([filedir currentfilename]),0.99);
    if size(im,1) ~= 128 || size(im,2) ~= 128
        currentfilename
        continue
    end
    allwhite = allwhite+(~im);
end

allwhite = allwhite>0.05*nfiles;
imshow(allwhite);
