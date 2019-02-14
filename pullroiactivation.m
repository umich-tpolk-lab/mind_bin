cd /nfs/tpolk/mind/freesurfer/func
flist = dir;
flist = {flist.name};
include = ~cellfun('isempty',strfind(flist,'pmind'));
subjectlist = flist(include);
subjectlist = char(subjectlist);
excludelist = ['pmindo100';'pmindy101';'pmindo107';'pmindo149'];
lhidx = load('newauditoryverticeslh.mat');
lhidx = lhidx.idx;
rhidx = load('newauditoryverticesrh.mat');
rhidx = rhidx.idx;
si = size(excludelist);
for e=1:si(1)
exclude = excludelist(e,:);
exc = find(ismember(subjectlist,exclude,'rows'));
subjectlist(exc,:)=[];
end
for s=1:length(subjectlist)
    subject = subjectlist(s,1:9);
    lhfname = [subject '/auditory/musicspeech.sm5.lh/speech-music-vs-fix/sig.nii.gz'];
    rhfname = [subject '/auditory/musicspeech.sm5.rh/speech-music-vs-fix/sig.nii.gz'];
    lhtemp=load_nifti(lhfname);
    rhtemp=load_nifti(rhfname);
    lhtemp=lhtemp.vol;
    rhtemp=rhtemp.vol;
    lhtemp=lhtemp(lhidx,:);
    rhtemp=rhtemp(rhidx,:);
    lhverno =sum(lhtemp>2);
    rhverno =sum(rhtemp>2);
    lhverticesnumber.(sprintf(subject))=lhverno;
    rhverticesnumber.(sprintf(subject))=rhverno;
end

savename = '/home/poortata/Desktop/MIND/sigverts.mat';
save(savename,'lhverticesnumber','rhverticesnumber');