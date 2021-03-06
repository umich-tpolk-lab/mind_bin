taskname = 'auditory';
BASEPATH ='/nfs/tpolk/mind/boldvariability/placebo/';
MATPATH = ([BASEPATH,taskname,'/pls/sd_datamats/']);

cd([BASEPATH,taskname,'/preproc'])
subjectlist = dir('*pmind*');
subjectlist = {subjectlist.name};
for sn=1:length(subjectlist)
    resid_2inc = [];
    
    a = load([MATPATH, 'SD_', char(subjectlist(sn)), '_BfMRIsessiondata.mat'], 'session_info','st_coords','num_subj_cond','st_evt_list', 'st_datamat');
       %% edit conditions labels 
       
    a.session_info.condition = a.session_info.condition(1:5);
    a.session_info.condition0 = a.session_info.condition;


       %% rename prefix to display ID in analysis
    a.session_info.datamat_prefix = ['SD_',char(subjectlist(sn))];

       %% edit condition counters
    a.session_info.num_conditions  = 5;
    a.session_info.num_conditions0 = 5;

    % update condition variables of condition 3   
    a.session_info.condition_baseline = {a.session_info.condition_baseline{1,1:5}};
    a.session_info.condition_baseline0 = a.session_info.condition_baseline;

    % num_subj_cond AND st_evt_list: ones or numbers = count of conditions
    a.num_subj_cond = a.num_subj_cond(1:5);
    a.st_evt_list   = a.st_evt_list(1:5);

    a.st_datamat = a.st_datamat(1:5,:);
        %% save new data file
    save ([MATPATH, 'SD_', char(subjectlist(sn)), '_BfMRIsessiondata.mat'], '-struct', 'a', '-append');

end