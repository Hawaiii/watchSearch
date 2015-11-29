% Brutally frontalize a test image
function [fDial] = frontalizeDial(watchImName, circleCenter, circleRadius, boarderSize)
if nargin < 4
    boarderSize = 10;
end
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
eparams = fitellipse(x,y);
% Crop image to ellipse and a small boarder
txtreme = atan(-eparams(4)*tan(eparams(5))/eparams(3));
txtreme = [txtreme txtreme+pi];
xxtreme = eparams(3)*cos(eparams(5))*cos(txtreme) - eparams(4)*sin(eparams(5))*sin(txtreme) + eparams(1);

txtreme = atan(eparams(4)*cot(eparams(5))/eparams(3));
txtreme = [txtreme txtreme+pi];
yxtreme = eparams(3)*sin(eparams(5))*cos(txtreme) + eparams(4)*cos(eparams(5))*sin(txtreme) + eparams(2);

yshift = max(1, round(min(yxtreme))-boarderSize)-1;
xshift = max(1, round(min(xxtreme))-boarderSize)-1;
im = im(yshift+1:min(size(im,1), round(max(yxtreme))+boarderSize),...
    xshift+1:min(size(im,2), round(max(xxtreme))+boarderSize),:);
eparams = fitellipse(x-xshift,y-yshift);

% Calculate affine transform from a circle to given ellipse
H = computeH(eparams, circleCenter, circleRadius);

% Apply affine transfrom to image
tform = projective2d(inv(H)');
RA = imref2d(size(im));%,[circleCenter(1)-circleRadius circleCenter(1)+circleRadius],...
    %[circleCenter(2)-circleRadius circleCenter(2)+circleRadius]);
fDial = imwarp(im, tform, 'OutputView', RA);

end
