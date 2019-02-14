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
roisize = [50 100 200 300 400 600 1000 2000 5000 10000] ;
taskname = 'auditory';%'visual' 'motor' 'tactile'
for s=1:length(subjectlist)
    subject = subjectlist(s,1:9);  
    cond1meanlist = nan(1,10);
    cond1maxlist = nan(1,10);
    cond2meanlist = nan(1,10); 
    cond2maxlist = nan(1,10);
    for i = 1:10
    fname = [subject '/' taskname '/funcmasked_sm_sm' num2str(roisize(i)) '.mat'];
    load(fname)
    cond1 = cond1twelvemskd(:);
    cond2 = cond2twelvemskd(:);
    cond1meanlist(i) = mean(cond1);
    cond1maxlist(i) = max(cond1);
    cond2meanlist(i) = mean(cond2);
    cond2maxlist(i) = max(cond2);
    end
    meancond1collect.(sprintf(subject))=cond1meanlist;
    meancond2collect.(sprintf(subject))=cond2meanlist;
    maxcond1collect.(sprintf(subject))=cond1maxlist;
    maxcond2collect.(sprintf(subject))=cond2maxlist;
end
savename = ['/home/poortata/Desktop/MIND/' taskname];
save([savename '_mean.mat']','meancond1collect','meancond2collect');
save([savename '_max.mat']','maxcond1collect','maxcond2collect');