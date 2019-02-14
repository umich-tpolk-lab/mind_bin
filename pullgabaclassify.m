cd /nfs/tpolk/mind/freesurfer/func
flist = dir;
flist = {flist.name};
include = ~cellfun('isempty',strfind(flist,'pmind'));
subjectlist = flist(include);
subjectlist = char(subjectlist);
excludelist = ['pmindo107';'pmindo149'];
si = size(excludelist);
for e=1:si(1)
    exclude = excludelist(e,:);
    exc = find(ismember(subjectlist,exclude,'rows'));
    subjectlist(exc,:)=[];
end
taskname = 'auditory';
for s=1:length(subjectlist)
    subject = subjectlist(s,1:9);
    cd /nfs/tpolk/mind/freesurfer/func
    cd(subject)
    [svmlh,knnlh,svmavg,knnavg] = classifier_gaba(taskname,'lh');
    [svmrh,knnrh,svmavg,knnavg] = classifier_gaba(taskname,'rh');
    svmlist = [svmlh,svmrh,svmavg];
    knnlist =[knnlh,knnrh,knnavg];
    knncollect.(sprintf(subject))=knnlist;
    svmcollect.(sprintf(subject))=svmlist;
end
savename = ['/home/poortata/Desktop/MIND/' taskname];
save([savename '_gabasvm.mat']','svmcollect');
save([savename '_gabaknn.mat']','knncollect');

%%

cd /nfs/tpolk/mind/freesurfer/func
flist = dir;
flist = {flist.name};
include = ~cellfun('isempty',strfind(flist,'pmind'));
subjectlist = flist(include);
subjectlist = char(subjectlist);
excludelist = ['pmindo107';'pmindo149'];
si = size(excludelist);
for e=1:si(1)
exclude = excludelist(e,:);
exc = find(ismember(subjectlist,exclude,'rows'));
subjectlist(exc,:)=[];
end
taskname = 'auditory';
for s=1:length(subjectlist)
    subject = subjectlist(s,1:9);
    cd /nfs/tpolk/mind/freesurfer/func
    cd(subject)
    fname = [taskname '/' 'musicspeech.sm5.12blks.lh'  '/distinct_gabalh'  '.mat'];
    betaslh = load(fname,'cond');
    betaslh = betaslh.cond';
    fname = [taskname '/' 'musicspeech.sm5.12blks.rh'  '/distinct_gabarh'  '.mat'];
    betasrh = load(fname,'cond');
    betasrh = betasrh.cond';
    betas = [betaslh,betasrh]';
    distinctive = corrdiff(betas,'distinctive_gaba');
    distwholegabacollect.(sprintf(subject))=distinctive;
end
savename = ['/home/poortata/Desktop/MIND/' taskname];
save([savename '_gabawholedist.mat']','distwholegabacollect');