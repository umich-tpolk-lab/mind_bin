cd /nfs/tpolk/mind/freesurfer/func
flist = dir;
taskname = 'auditory';
tname = 'aud';
flist = {flist.name};
include = ~cellfun('isempty',strfind(flist,'mind'));
subjectlist = flist(include);
subjectlist = char(subjectlist);
excludelist = ['pmindo107';'pmindo141';'dmindo141';'pmindy138';'dmindy138';'pmindy145';'dmindy145';'pmindo143';'pmindy147';'dmindy147'];
si = size(excludelist);
for e=1:si(1)
exclude = excludelist(e,:);
exc = find(ismember(subjectlist,exclude,'rows'));
subjectlist(exc,:)=[];
end
roisize = [50 100 200 300 400 600 1000 2000 5000 10000] ;     
for s=1:length(subjectlist)
    subject = subjectlist(s,1:9);
    hcorrlist = nan(1,10);
    for i = 1:10
    fname = [subject '/' taskname '/hcorr_' tname num2str(roisize(i)) '.mat'];
    load(fname)
    hcorrlist(i) = hcorr;
    end
    hcorrcollect.(sprintf(subject))=hcorrlist;
end

savename = ['/home/poortata/Desktop/MIND/' taskname '_hcorr.mat']';
save(savename,'hcorrcollect');