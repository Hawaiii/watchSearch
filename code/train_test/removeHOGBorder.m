% Read VLHOGWatch.mat and VLHOGnonWatch.mat
load('VLHOGWatch.mat');
load('VLHOGnonWatch.mat');
% Zero-out everything out of boundary
load('watchboundary.mat');

BLOCKSIZE = 8;
for y = 1:16,
    for x = 1:16,
        if sum(sum(allwhite((y-1)*BLOCKSIZE+1:y*BLOCKSIZE, ...
                (x-1)*BLOCKSIZE+1:x*BLOCKSIZE))) == 0
            VLHOGWatch(:,(x-1)*16+y:16*16:end) = 0;
            VLHOGnonWatch(:,(x-1)*16+y:16*16:end) = 0;
        end
    end
end

% Save as VLHOGWatchCrop.mat and VLHOGnonWatchCrop.mat
save('VLHOGWatchCrop.mat','VLHOGWatch');
save('VLHOGnonWatchCrop.mat','VLHOGnonWatch');
