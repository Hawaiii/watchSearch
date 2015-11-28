% Brutally frontalize a test image
function [fDial] = frontalizeDial(watchImName, circleRadius)
% Read image, Make user annotate 4 points on the ellipse
im = im2double(imread(watchImName));
f = figure(1); imshow(im); title('Pick four points on the dial contour ellipse.');
[x,y] = getpts(f);
% ellipsepts = zeros(size(x,1),2); % each row a point
% ellipsepts(:,1) = x;
% ellipsepts(:,2) = y;

% Locate the center of ellipse and use one point as 0 degree, calculate the
% angle for the rest 3 points
% Calculate ellipse center
a = fitellipse(x,y);

% Map those 3 points to points on circle with radius circleRadius

% Calculate affine transform

% Apply affine transfrom to image

fDial = [];

end
