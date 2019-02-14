 function [svm_misclas, knn_misclas, svm_misclass_gabaavg, knn_misclas_gabaavg ]=classifier_gaba(task,hemi)
% Takes in session name, taskname and roisize. (Eg: classifier('pmindy113', 'auditory', '10000') )
%Returns misclassification value
CorrectLabels = [1 1 1 1 1 1 2 2 2 2 2 2];
fname = [task '/' 'musicspeech.sm5.12blks.' hemi '/distinct_gaba' hemi '.mat'];
betas = load(fname,'cond');
betas = betas.cond';
kfold = 12; % How many folds (divisions of data) for cross-validation 
% kfold = No.of observations for leave one out
neighbour = 1; % No. of neighbours to use in Nearest Neighbour classsification.
svm_misclas = svm(kfold,betas,CorrectLabels);
knn_misclas = knn(neighbour,betas,kfold,CorrectLabels);
[svm_misclass_gabaavg, knn_misclas_gabaavg] =  svm_misclass_gaba(task);
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

%% Putting together two voxel
     function [svm_misclas_gab,knn_misclas_gab] = svm_misclass_gaba(task1)
        CorrectLabels1 = [1 1 1 1 1 1 2 2 2 2 2 2];
        fname1 = [task1 '/' 'musicspeech.sm5.12blks.lh/distinct_gabalh.mat'];
        betas1 = load(fname1,'cond');
        betas1 = betas1.cond';
        fname2 = [task1 '/' 'musicspeech.sm5.12blks.rh/distinct_gabarh.mat'];
        betas2 = load(fname2,'cond');
        betas2 = betas2.cond';
        betas3 = [betas1,betas2];
        kfold1 = 12; % How many folds (divisions of data) for cross-validation 
        % kfold = No.of observations for leave one out
        neighbour1 = 1; % No. of neighbours to use in Nearest Neighbour classsification.
        svm_misclas_gab = svm(kfold1,betas3,CorrectLabels1);
        knn_misclas_gab = knn(neighbour1,betas3,kfold1,CorrectLabels1);

     end
 end
 
