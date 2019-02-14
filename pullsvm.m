cd /nfs/tpolk/mind/freesurfer/func
flist = dir;
taskname = 'auditory';
flist = {flist.name};
include = ~cellfun('isempty',strfind(flist,'pmind'));
subjectlist = flist(include);
subjectlist = char(subjectlist);
excludelist = ['pmindo100';'pmindy101';'pmindo107';'pmindo149'];
si = size(excludelist);
for e=1:si(1)
exclude = excludelist(e,:);
exc = find(ismember(subjectlist,exclude,'rows'));
subjectlist(exc,:)=[];
end
%roisize = [50 100 200 300 400 600 1000 2000 5000 10000] ;     
roisize=[1800];
for s=1:length(subjectlist)
    subject = subjectlist(s,1:9);
    svmmisclaslist = nan(1,1);
    knnmisclaslist = nan(1,1);
    for i = 1:1
    fname = [subject '/' taskname '/classify_' taskname num2str(roisize(i)) '.mat'];
    load(fname)
    svmmisclaslist(i) = svm_misclas;
    knnmisclaslist(i) = knn_misclas;
    end
    svmcollect.(sprintf(subject))=svmmisclaslist;
    knncollect.(sprintf(subject))=knnmisclaslist;
end

savename = ['/home/poortata/Desktop/MIND/' taskname '_svm1800.mat']';
save(savename,'svmcollect');