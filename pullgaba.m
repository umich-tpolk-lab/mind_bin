cd /nfs/tpolk/mind/mrs
taskname = 'auditory'; %primaryvisual, auditory,sensorymotor,ventrovisual
lhgaba = load(['left' taskname '.mat'],'allstats');
rhgaba = load(['right' taskname '.mat'],'allstats');
flist = dir;
flist = {flist.name};
include = ~cellfun('isempty',strfind(flist,'mind'));
subjectlist = flist(include);
excludelist = [];
si = size(excludelist);
charsubjectlist = char(subjectlist);
for e=1:si(1)
exclude = excludelist(e,:);
exc = find(ismember(subjectlist,exclude));
charsubjectlist(exc,:)=[];
end

for s=1:length(subjectlist)
    subject=subjectlist(s);
    lhid = strmatch(subject,lhgaba.allstats.subject); 
    lh = lhgaba.allstats.GABAuncorrected(lhid);
    rhid = strmatch(subject,rhgaba.allstats.subject);
    rh = rhgaba.allstats.GABAuncorrected(rhid);
    gabacollect.(sprintf(char(subject)))=[mean([lh,rh]) lh rh];   
end
savename = ['/home/poortata/Desktop/' taskname '_UC_AUDGABA.mat']';
save(savename,'gabacollect');