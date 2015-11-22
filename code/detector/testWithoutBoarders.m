% Result:
% truepos =        5764
% trueneg =        1115
% falsepos =        4649
% falseneg =     0

load('boundaryWatchSVMParams.mat');

% Load tests
load('VLHOGWatch.mat');
load('VLHOGnonWatch.mat');

test_data = vertcat(VLHOGnonWatch,VLHOGWatch);
test_label = vertcat(zeros(size(VLHOGnonWatch,1),1), ones(size(VLHOGWatch,1),1));

truepos = 0;
trueneg = 0;
falsepos = 0;
falseneg = 0;
for i = 1:size(test_data,1)
    confidence = HOGContainsWatchWB(test_data(i,:), w, b);
    if test_label(i) == 1 
        if confidence ~= -1
            truepos = truepos + 1;
        else
            falseneg = falseneg + 1;            
        end
    else
        if  confidence == -1
            trueneg = trueneg + 1;
        else
            falsepos = falsepos + 1;
        end
    end
end