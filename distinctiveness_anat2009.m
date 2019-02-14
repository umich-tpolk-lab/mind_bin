%%Iterate through files
function distinctiveness_anat2009(subject,maskname)
cd('/nfs/tpolk/mind/freesurfer/func/')
cd(subject)
classifier(maskname)


    %% Classifier
    function classifier(mask)
        % Takes in taskname
        %Returns misclassification value in anatomical ROI

        CorrectLabels = [1 1 1 1 1 1 2 2 2 2 2 2];
        fname = [mask '.mat'];
        cond = load(fname);
        cond1 = cond.cond1;
        cond2 = cond.cond2;
        betas = [cond1 cond2];
        betas = betas';
        kfold = 12; % How many folds (divisions of data) for cross-validation 
        % kfold = No.of observations for leave one out
        neighbour = 1; % No. of neighbours to use in Nearest Neighbour classsification.
        svm_misclas = svm(kfold,betas,CorrectLabels);
        knn_misclas = knn(neighbour,betas,kfold,CorrectLabels);
        distinctiveness = distinct(betas);
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


%% Distinctiveness
        function distinctive = distinct(betas)
% Computes the difference between the avg within-group and between-group
% correlations in the matrix data.
% betas: Matrix in which rows are blocks & columns are voxels
            corrmatrix = corrcoef(betas','rows','pairwise');
            cond1label = [1 1 1 1 1 1 0 0 0 0 0 0];
            cond1label = logical(cond1label);
            cond2label = ~cond1label;
            within1 = corrmatrix(cond1label,cond1label);
            within2 = corrmatrix(cond2label,cond2label);
            between = corrmatrix(cond1label,cond2label);
            sumwithin1 = sum(within1);
            sumwithin2 = sum(within2);
            avgwithin = (sum(sumwithin1) + sum(sumwithin2) - 12)/(60);
            avgbetween = sum(sum(between))/(36);
            distinctive = avgwithin - avgbetween;
        end
    
    
    
        savename = [mask '_distinct.mat'];
        save(savename,'svm_misclas', 'knn_misclas','distinctiveness')
    end
end
 