function removeStrap(imname)
readdir = '../../data/AmazonWatchClean/';
founddir = '../../data/AmazonWatchCropped/';
notfounddir = '../../data/AmazonWatchNonProcess/';

im = imread([readdir imname]);
bw = rgb2gray(im) < 254;
% imshow(bw);

s = regionprops(bw, 'centroid');
centroids = cat(1, s.Centroid); 
% if size(centroids) > 1
%     imwrite(im, [notfounddir imname]);
%     return;
% else
dist = pdist2(centroids, [size(im,2)/2, size(im,1)/2]);
[distval, cidx] = min(dist);
centroid = centroids(cidx,:);
[y,x] = find(bw==1);
xmin = min(x);
xmax = max(x);
rad = round((xmax-xmin)/2);
ymin = round(centroid(2)-rad);
ymax = round(centroid(2)+rad);
if ymin < 1 || ymax > size(im,1)
    imwrite(im, [notfounddir imname]);
    return;
end
imseg = im(ymin:ymax,xmin:xmax,:);
imseg = imresize(imseg, [128 128]);
imwrite(imseg, [founddir imname]);
% end

% found = 0;
% maxrad = min(size(im))/2;
% minrad = maxrad/3;
% rad = maxrad;
% while rad >= minrad
%     [centers] = imfindcircles(I,rad,'Sensitivity',0.998);
%     if size(centers,1) > 1
%         viscircles(centers(1,:), rad,'EdgeColor','r');
%         x = input(prompt);
%         if size(x,1) < 1 % enter: meaning circle is right
%             
%             ymin = centers(1,2)-rad*64/50;
%             ymax = centers(1,2)+rad*64/50;
%             xmin = centers(1,1)-rad*64/50;
%             xmax = centers(1,1)+rad*64/50;
%             
%             rymin = max(1, ymin);
%             rymax = min(size(im,1), ymax);
%             rxmin = max(1, xmin);
%             rxmax = min(size(im,2), xmax);
%             
%             ypadmin = rymin-ymin;
%             ypadmax = ymax-rymax;
%             xpadmin = rxmin-xmin;
%             xpadmax = xmax-rxmax;
%             
%             dial = 
%             
%         else
%             if x == 0 % continue
%                 continue;
%             else
%                 if x == 9 % stop
%                     imwrite(im, [notfounddir imname]);
%                     return;
%                 end
%             end
%         end
%     end
%     rad = rad - 2;
%     end
% end
% 
% if ~found
%     imwrite(im, [notfounddir imname]);
% end

end