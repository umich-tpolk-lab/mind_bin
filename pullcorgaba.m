cd /nfs/tpolk/mind/mrs
taskname = 'auditory'; %primaryvisual, auditory,sensorymotor,ventrovisual
lhgaba = load(['left' taskname '.mat'],'allstats');
rhgaba = load(['right' taskname '.mat'],'allstats');
avggaba = load([taskname '.mat'],'allstats');
flist = dir;
flist = {flist.name};
include = ~cellfun('isempty',strfind(flist,'mind'));
subjectlist = flist(include);
subjectlist = char(subjectlist);
for s=1:length(subjectlist)
    subject=subjectlist(s,1:8);
    lhid = strmatch(subject,lhgaba.allstats.subject); 
    lh = lhgaba.allstats.corrected(lhid(1));
    rhid = strmatch(subject,rhgaba.allstats.subject);
    rh = rhgaba.allstats.corrected(rhid);
    id = strmatch(subject,avggaba.allstats.subject);
    avg = avggaba.allstats.corrected(id);
    gabacollect.(sprintf(subject))=[mean([lh,rh]) lh rh];   
end
savename = ['/home/poortata/Desktop/MIND/' taskname '_corGABA.mat']';
save(savename,'gabacollect');