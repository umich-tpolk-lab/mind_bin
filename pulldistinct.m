cd /nfs/tpolk/mind/freesurfer/func
flist = dir;
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
roisize = [1800] ;
taskname = 'auditory';%'visual' 'motor' 'tactile'
for s=1:length(subjectlist)
    subject = subjectlist(s,1:9);  
    distinctlist = nan(1,1);
    withinlist = nan(1,1); 
    betweenlist = nan(1,1);
    for i = 1:1
    fname = [subject '/' taskname '/distinct_sm_sm' num2str(roisize(i)) '.mat'];
    load(fname)
    distinctlist(i) = distinctive;
    withinlist(i) = avgwithin;
    betweenlist(i) = avgbetween;
    end
    distcollect.(sprintf(subject))=distinctlist;
    withincollect.(sprintf(subject))=withinlist;
    betweencollect.(sprintf(subject))=betweenlist;
end
savename = ['/home/poortata/Desktop/MIND/' taskname];
save([savename '_dist1800.mat']','distcollect');
save([savename '_within1800.mat']','withincollect');
save([savename '_between1800.mat']','betweencollect');