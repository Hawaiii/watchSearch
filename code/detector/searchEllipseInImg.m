function [bestEllipse] = searchEllipseInImg(img, minMajor, ...
    minMinor, maxMinor, minThresh)
% Input:
%  img: color or grayscale image
%  minMajor: minimum allowed major axis
%  minMinor: minimum allowed minor axis
% Output:
%  bestEllipse: 5x1 matrix
%  (before)ellipses: 5xK matrix, each column is [x0 y0 majorAx minorAx theta]

if nargin < 2
    minMajor = 100;
end
if nargin < 3
    minMinor = 50;
end
if nargin < 4
    maxMinor = 350;
end
if nargin < 5
    minThresh = 2000; % TODO: adjust this 
end
ellipseFitThresh = 0.7;

ellipses = [];
bestEllipse = [];
bestVal = 0;

% get edge
bw = edge(img, 'canny');
[edgex, edgey] = find(bw);
N = size(edgex,1);

accum = zeros(maxMinor-minMinor+1,1);
for i = 1:N
    if edgex(i) < 1 || edgey(i) < 1
        continue
    end
    for j = i+1:N
        if edgex(j) < 1 || edgey(j) < 1
            continue
        end
        if pdist([edgex(i) edgey(i); edgex(j) edgey(j)]) > minMajor
            x0 = mean(edgex(i),edgex(j));
            y0 = mean(edgey(i),edgey(j));
            a = sqrt(sumsqr([edgex(j)-edgex(i) edgey(j)-edgey(i)]))/2;
            if edgex(i) ~= edgex(j)
                theta = atan((edgey(j)-edgey(i))/(edgex(j)-edgex(i)));
            else
                theta = pi/2;
            end
            
            for k = [1:i-1 i+1:j-1 j+1:N]
                if edgex(k) < 1 || edgey(k) < 1
                    continue
                end
                d = pdist([x0 y0; edgex(k) edgey(k)]);
                if d > minMajor
                    f = pdist([edgex(k) edgey(k); edgex(j) edgey(j)]);
                    costau = (a^2+d^2-f^2)/(2*a*d);
                    b = sqrt((a^2*d^2*(1-costau^2))/(a^2-d^2*costau^2));
                    bidx = round(b)-minMinor+1;
                    if bidx > 0 && bidx <= maxMinor-minMinor+1
                        accum(bidx) = accum(bidx) + 1;
                    end
                end
            end
            [maxval, maxid] = max(accum);
            if maxval > minThresh % Ellipse is detected
                if maxval > bestVal
                    maxval
                    bestEllipse = [x0; y0; a; maxid+minMinor-1; theta];
                    bestVal = maxval;
                end
                % Record ellipse
                ellipses = [ellipses [x0; y0; a; maxid+minMinor-1; theta]];
                % Find all points on this ellipse
                valid = (edgex > 0 & edgey > 0);
                distToE = ( (cos(theta)*(edgex-x0)+sin(theta)*(edgey-y0)) /a).^2 ...
                +( (sin(theta)*(edgex-x0)-cos(theta)*(edgey-y0)) /b).^2;
                % Remove all points on this ellipse
                ptsOnE = (valid & distToE < ellipseFitThresh);
                edgex(ptsOnE) = -1;
                edgey(ptsOnE) = -1;
                % Clear accumulator
                accum = zeros(maxMinor-minMinor+1,1);
            end
        end
    end
end

end