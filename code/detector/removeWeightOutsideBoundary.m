% Remove hog outside boundary
load('watchboundary.mat');
load('watchSVM.mat');
w = svm.Beta;

BLOCKSIZE = 8;
for y = 1:16,
    for x = 1:16,
        if sum(sum(allwhite((y-1)*BLOCKSIZE+1:y*BLOCKSIZE, ...
                (x-1)*BLOCKSIZE+1:x*BLOCKSIZE))) == 0
            w((x-1)*16+y:16*16:end) = 0;
        end
    end
end

b = svm.Bias;
save('boundaryWatchSVMParams.mat', 'w','b');