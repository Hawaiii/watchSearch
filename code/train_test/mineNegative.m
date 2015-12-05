% vidName = '../../data/TODO';
vidName = '../../data/vid/negative_sample1.avi';
writeFolderName = '../../data/mineNeg/';

load('watchSVM.mat');
% read video
vid = vision.VideoFileReader(vidName);
fn = 0;
count = 1;
% for every 30 frames, run watch detector on frame
while ~isDone(vid)
% save 128x128 windows that were detected as positive
    I = step(vid);
    I = im2single(I);
    if mod(fn,30) == 0
        count = saveWatchSlidingWindow(I, svm, count, writeFolderName);
    end
    fn = fn+1;
    
end