function [confidence] = HOGContainsWatch(hog, classifier)
% Returns -1 if a watch cannot be found, confidence otherwise
% 
% Input:
%  hog: hog featuer, 1x(16*16*31)
%  svm: the binary svm classifier trained on classifying watches
% Output:
%  confidence: -1 if svm decides there is no watch in hog, distance 
%              from the hog to the svm margin otherwise
confidence = predict(classifier, hog);
if confidence == 1
   confidence = hog*classifier.Beta+classifier.Bias;
end    

end