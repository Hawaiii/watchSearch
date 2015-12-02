filedir = '../../data/AmazonWatchClean/';
imagefiles = dir([filedir '*.jpg']);
nfiles = length(imagefiles); 
for ii=1:nfiles
    currentfilename = imagefiles(ii).name;
    removeStrap(currentfilename);
end