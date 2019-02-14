taskname = 'rest';
BASEPATH ='/nfs/tpolk/mind/boldvariability/placebo/';
MATPATH = ([BASEPATH,taskname,'/pls/sd_datamats/']);

cd([BASEPATH,taskname,'/preproc'])
subjectlist = dir('*pmind*');
subjectlist = {subjectlist.name};
subjectlist(strcmp(subjectlist,'pmindy111'))=[];

for sn=1:length(subjectlist)
    a = load([MATPATH, 'SD_', char(subjectlist(sn)), '_BfMRIsessiondata.mat'], 'st_coords','st_datamat');
    a.pls_data_path = (MATPATH);
    save ([MATPATH, 'SD_', char(subjectlist(sn)), '_BfMRIsessiondata.mat'], '-struct', 'a', '-append');
end