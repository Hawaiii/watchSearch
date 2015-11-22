% Find the pixels that are always white in the training data
filedir = '../../data/AmazonWatchSquare/';
imagefiles = dir([filedir '*.jpg']);
nfiles = length(imagefiles);    % Number of files found
allwhite = zeros(128,128);
for ii=1:nfiles
    currentfilename = imagefiles(ii).name;
    im = im2bw(imread([filedir currentfilename]),0.99);
    allwhite = allwhite+(~im);
end

allwhite = allwhite>0.1*nfiles;
imshow(allwhite);
