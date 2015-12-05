run('/Users/hawaiii/Developer/vlfeat-0.9.20/toolbox/vl_setup');

% load HOGs
load('VLHOGWatch.mat');
load('VLHOGnonWatch.mat');
VLHOGnonWatch = VLHOGnonWatch(1:17166,:);


% Small experiment
% train_data_small = vertcat(VLHOGnonWatch(randperm(size(VLHOGnonWatch,1),50),:),...
%     VLHOGWatch(randperm(size(VLHOGWatch,1),50),:));
% train_label_small = vertcat(zeros(50,1), ones(50,1));
% ecoc = fitcecoc(train_data_small, train_label_small,'Verbose',2);
% whog = reshape(single(ecoc.BinaryLearners{1}.Beta),16,16,31);
% imwhog = vl_hog('render', whog, 'verbose') ;
% clf ; imagesc(imwhog) ; colormap gray ;

train_percent = 0.9;
watch_idx = randperm(size(VLHOGWatch,1));
non_watch_idx = randperm(size(VLHOGnonWatch,1));
% Train data
train_data = vertcat(VLHOGnonWatch(...
    non_watch_idx(1:round(train_percent*size(VLHOGnonWatch,1))),:),...
    VLHOGWatch(watch_idx(1:round(train_percent*size(VLHOGWatch,1))),:));
train_label = vertcat(zeros(round(train_percent*size(VLHOGnonWatch,1)),1), ...
    ones(round(train_percent*size(VLHOGWatch,1)),1));
% Test data
test_data = vertcat(VLHOGnonWatch(...
    non_watch_idx(round(train_percent*size(VLHOGnonWatch,1))+1:end),:),...
    VLHOGWatch(watch_idx(round(train_percent*size(VLHOGWatch,1))+1:end),:));
test_label = vertcat(zeros(size(VLHOGnonWatch,1)-round(train_percent*size(VLHOGnonWatch,1)),1), ...
    ones(size(VLHOGWatch,1)-round(train_percent*size(VLHOGWatch,1)),1));

ecoc = fitcecoc(train_data, train_label,'Verbose',2);
% ecoc = fitcecoc(train_data, train_label,'CrossVal','on','Verbose',2);
% CVecoc = crossval(ecoc);
whog = reshape(single(ecoc.BinaryLearners{1}.Beta),16,16,31);
imwhog = vl_hog('render', whog, 'verbose') ;
clf ; imagesc(imwhog) ; colormap gray ;

svm = ecoc.BinaryLearners{1};
save('watchSVM.mat', 'svm');

%% Run on test
truepos = 0;
trueneg = 0;
falsepos = 0;
falseneg = 0;
for i = 1:size(test_data,1)
    confidence = HOGContainsWatch(test_data(i,:), svm);
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
truepos
trueneg
falsepos
falseneg