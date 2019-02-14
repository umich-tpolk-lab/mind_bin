cd /nfs/tpolk/mind/freesurfer
flist = dir;
flist = {flist.name};
include = ~cellfun('isempty',strfind(flist,'mind'));
subjectlist = flist(include);
subjectlist = char(subjectlist);
excludelist = [];
si = size(excludelist);
for e=1:si(1)
exclude = excludelist(e,:);
exc = find(ismember(subjectlist,exclude,'rows'));
subjectlist(exc,:)=[];
end
subjectlist = char(subjectlist);
for s=1:length(subjectlist)
    subject = subjectlist(s,1:8);
    copyfile([subject '/stats/lh.aparc.stats'],['/home/poortata/Desktop/MIND/Struct/' subject '_lh_aparc.txt']);
    copyfile([subject '/stats/rh.aparc.stats'],['/home/poortata/Desktop/MIND/Struct/' subject '_rh_aparc.txt']);
    cd /home/poortata/Desktop/MIND/Struct/
    FID=fopen([subject '_lh_aparc.txt'],'r');
    if FID== -1,error('Cannot open file'),end
    data = textscan(FID, '%s', 'delimiter', '\n', 'whitespace', '');
    CStr = data{1};
    fclose(FID);
    Index = strfind(CStr,'# ColHeaders');
    FID=fopen([subject '_lh_aparc.txt'],'w');
    CStr(1:find(~cellfun(@isempty,Index)))=[];
    fprintf(FID, '%s\n', CStr{:});
    fclose(FID);
    
    FID2=fopen([subject '_rh_aparc.txt'],'r');
    if FID2== -1,error('Cannot open file'),end
    data2 = textscan(FID2, '%s', 'delimiter', '\n', 'whitespace', '');
    CStr2 = data2{1};
    fclose(FID);
    Index2 = strfind(CStr2,'# ColHeaders');
    FID2=fopen([subject '_rh_aparc.txt'],'w');
    CStr2(1:find(~cellfun(@isempty,Index2)))=[];
    fprintf(FID2, '%s\n', CStr2{:});
    fclose(FID2);
    
    clearvars -except subjectlist
    cd /nfs/tpolk/mind/freesurfer
    
end