IMGSIZE = 128;
MAXVAL = 255;
writedir = '../../data/AmazonWatchSquare/';
rotatedir = '../../data/AmazonWatchSquareRotated/';

datadir = '../../data/AmazonWatchClean/';
imagefiles = dir([datadir '*.jpg']);
nfiles = length(imagefiles);    % Number of files found
for ii=1:nfiles
    currentfilename = imagefiles(ii).name;
    currentimage = imread([datadir currentfilename]);
   
% Crop empty rows on the boarders of image
    rowstart = 1; rowend = size(currentimage,1);
    colstart = 1; colend = size(currentimage,2);
    while size(unique(currentimage(rowstart, :,1)),2) < 3 ...
            && size(unique(currentimage(rowstart, :,2)),2) < 3 ...
            && size(unique(currentimage(rowstart, :,3)),2) < 3 ...
            && rowstart < rowend
%     while sum(sum(currentimage(rowstart, :,:)-255)) == 0 && rowstart < rowend
        rowstart = rowstart + 1;
    end
    while size(unique(currentimage(rowend, :,1)),2) < 3 ...
            && size(unique(currentimage(rowend, :,2)),2) < 3 ...
            && size(unique(currentimage(rowend, :,3)),2) < 3 ...
            && rowstart < rowend
%     while sum(sum(currentimage(rowend,:,:)-255)) == 0 && rowend > rowstart
        rowend = rowend - 1;
    end
    while size(unique(currentimage(:,colstart, 1)),1) < 3 ...
            && size(unique(currentimage(:,colstart, 2)),2) < 3 ...
            && size(unique(currentimage(:,colstart, 3)),2) < 3 ...
            && colstart < colend
%     while sum(sum(currentimage(:,colstart,:)-255)) == 0 && colstart < colend
        colstart = colstart + 1;
    end
    while size(unique(currentimage(:,colend, 1)),1) < 3 ...
            && size(unique(currentimage(:,colend, 2)),2) < 3 ...
            && size(unique(currentimage(:,colend, 3)),2) < 3 ...
            && colstart < colend
%     while sum(sum(currentimage(:,colend,:)-255)) == 0 && colend > colstart
        colend = colend - 1;
    end
    currentimage = currentimage(rowstart:rowend, colstart:colend, :);
   
% Resize image to 128*128
    if size(currentimage,1) >= size(currentimage,2)
        currentimage = imresize(currentimage, [IMGSIZE, NaN]);
    else
        currentimage = imresize(currentimage, [NaN, IMGSIZE]);
    end
% Pad image to square
    currentimage = padarray(currentimage, [floor((IMGSIZE-size(currentimage,1))/2),...
        floor((IMGSIZE-size(currentimage,2))/2)], MAXVAL);
    currentimage = padarray(currentimage, [IMGSIZE-size(currentimage,1),...
        IMGSIZE-size(currentimage,2)], MAXVAL,'post');
% Rotate to 8 directions
    imwrite(currentimage, [writedir currentfilename(1:size(currentfilename,2)-4) '_0.jpg']);
    imwrite(currentimage, [rotatedir currentfilename(1:size(currentfilename,2)-4) '_0.jpg']);
    for d = 1:7
        rotatedimage = imrotate(currentimage, -45*d, 'crop'); 
        Mrot = ~imrotate(true(size(currentimage)),-45*d,'crop');
        rotatedimage(Mrot) = 255;
        %rotatedimage(Mrot&~imclearborder(Mrot)) = 255;
        imwrite(rotatedimage, [rotatedir currentfilename(1:size(currentfilename,2)-4) '_' num2str(d) '.jpg']);
    end
    ii
end