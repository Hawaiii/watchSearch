% Start camera

% For each frame 

% detect watch
% frame: h x w x 3 image 
% watchSeg: 128x128x3 matrix, image segment containing a watch
watchSeg = detectWatchOnFame(frame);

% match watch

% pop GUI and idle for 30 seconds