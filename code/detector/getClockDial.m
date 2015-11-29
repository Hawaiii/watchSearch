function dial = getClockDial(watchImgName)
MINRADIUS = 45;

im = im2double(imread(watchImgName)); % assuming color image right now

[bw, cannythres] = edge(rgb2gray(im), 'canny');

%% Find watch dial by finding the largest circle on watch using Hoff transform
found = 0;
radius = round(min(size(im,1), size(im,2))/2);
while radius > MINRADIUS
    [centers, radii] = imfindcircles(bw,100,'Sensitivity',0.997);
%     [centers, radii] = imfindcircles(bw,radius,'Sensitivity',0.9);
    if size(centers,1) > 1
        found = 1;
        break;
    end    
    radius = radius - 5;
end

% TODO If no circle is found, find largest rectangle on watch

%% resize the dial
if found
    dial = im(max(1, centers(1,2)-radii(1)):min(size(im,1),centers(1,2)+radii(1)),...
    max(1,centers(1,1)-radii(1)):min(size(im,2),centers(1,1)+radii(1)),:);
else
    dial = [];
end
end