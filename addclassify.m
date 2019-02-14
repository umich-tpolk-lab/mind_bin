function addclassify( session, mainfile, currfile )
%addclassify Adds classification accuracy stats from currfile to mainfile

currstats = load(currfile); % Load the distinctiveness stats from the current session

if exist(mainfile, 'file') % If we've already saved some sessions then augment the file
    load(mainfile);
    
    % Now look to see if the current session is already in mainfile
    idx = 0;
    for i = 1:size(allstats.svm)
        if session == allstats.session(i,:)
            idx = i;
        end
    end
    if idx  % If this session has been saved before then remove the previous data
        allstats.svm(idx)=[];
        allstats.knn(idx)=[];
        allstats.session(idx,:)=[];
    end
    
    % Now add the data from the current session
    allstats.svm = [allstats.svm ; currstats.svm_misclas];
    allstats.knn = [allstats.knn ; currstats.knn_misclas];
    allstats.session = [allstats.session ; session];
    
else  % Haven't saved any data before so start from scratch
    allstats.svm = currstats.svm_misclas;
    allstats.knn = currstats.knn_misclas;
    allstats.session = session;
end

save(mainfile,'allstats');

end
