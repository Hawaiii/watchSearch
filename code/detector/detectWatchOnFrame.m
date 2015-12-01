function [watchSeg] = detectWatchOnFrame(frame, svm)
       [x0, y0, width, height] = detectWatchSlidingWindow(im, svm);
       if x0 <= 0 || y0 <= 0
           watchSeg = [];
       else
        watchSeg = frame(y0:y0+height, x0:x0+width,:);
       end
end
