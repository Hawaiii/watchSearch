function [confidence] = HOGContainsWatchWB(hog, w, b)
% Returns -1 if a watch cannot be found, confidence otherwise
% 
% Input:
%  hog: hog featuer, 1x(16*16*31)
%  w: weight vector learned by svm classifier
%  b: offset vector learned by svm classifier
% Output:
%  confidence: -1 if svm decides there is no watch in hog, distance 
%              from the hog to the svm margin otherwise

confidence = hog*w + b;
if confidence < 0
    confidence = -1;
else
    confidence = confidence / (w'*w);
end

end