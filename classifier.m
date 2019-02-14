function classifier(task,roisize)
% Takes in session name, taskname and roisize. (Eg: classifier('pmindy113', 'auditory', '10000') )
%Returns misclassification value
CorrectLabels = [1 1 1 1 1 1 2 2 2 2 2 2];
fname = [task '/' 'funcmasked_sm_sm' roisize '.mat'];
betas = load(fname,'betas');
betas = betas.betas';
kfold = 12; % How many folds (divisions of data) for cross-validation 
% kfold = No.of observations for leave one out
neighbour = 1; % No. of neighbours to use in Nearest Neighbour classsification.
svm_misclas = svm(kfold,betas,CorrectLabels);
knn_misclas = knn(neighbour,betas,kfold,CorrectLabels);

%% SVM Classification with Nfold cross validation
    function svm_misclas = svm(Nfolds,data,CorrectLabels)
        svmMdl = fitcsvm(data,CorrectLabels,'Kfold',Nfolds);
        svm_misclas  = kfoldLoss(svmMdl);
    end

%% k-Nearest Neighbor classification with N-fold cross validation
    function knn_value = knn(neighbours,data,Nfolds,CorrectLabels)
        % How many folds (divisions of data) for cross-validation = No.of
        % observations for leave one out
        knnMdl = fitcknn(data,CorrectLabels,'NumNeighbors',neighbours,'Kfold',Nfolds);
        knn_value = kfoldLoss(knnMdl);
    end

savename = [task '/classify_' task roisize '.mat'];
save(savename,'svm_misclas', 'knn_misclas')
end
 
