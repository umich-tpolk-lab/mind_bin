function SD_regress_out(factor,taskname)

if strcmp(factor,'age')
    if strcmp(taskname,'auditory')
       factor = [79,78,69,65,73,69,67,69,74,70,67,65,74,69,67,81,66,69,67,65,71,69,65,66,70,74,71,75,70,74,65,76,75,69,78,77,67,65,20,23,26,28,22,26,22,22,19,29,29,25,20,20,23,27,25,20,24,21,21];  
    else
        factor = [69,79,71,78,69,65,73,69,67,69,74,70,67,65,74,69,67,81,66,69,67,65,71,69,65,66,70,74,71,75,70,74,65,76,75,69,78,77,67,65,21,20,23,26,28,22,26,22,22,19,29,29,25,20,20,23,27,25,20,24,21,21];
    end
end
factor = factor';
%% Init folder paths and variables

BASEPATH ='/nfs/tpolk/mind/boldvariability/placebo/';
MATPATH = ([BASEPATH,taskname,'/pls/mean_datamats/']);

cd([BASEPATH,taskname,'/preproc'])
subjectlist = dir('*pmind*');
subjectlist = {subjectlist.name};
subjectlist(strcmp(subjectlist,'pmindy111'))=[];

%% Find coordiantes of gray matter mask
GM_coords = load_nii('/nfs/tpolk/mind/boldvariability/placebo/scripts/avg152_T1_gray_mask_90_2mm.nii');
GM_coords = reshape(GM_coords.img, [],1);
GM_coords = find(GM_coords);


cnds = [1,2,3,4,5];

%% load _BfMRIsessiondata.mats to create matrix of st.datamats to regress out the factor
for CondNo = cnds
st_collect = NaN(size(GM_coords,1),length(subjectlist));
for sn=1:length(subjectlist)
    a = load([MATPATH, 'mean_', char(subjectlist(sn)), '_BfMRIsessiondata.mat'], 'st_coords','st_datamat');
    for stid = 1:size(GM_coords,1)
        if ismember(GM_coords(stid),a.st_coords)
            incidx = a.st_coords==GM_coords(stid);
            st_collect(stid,sn) = a.st_datamat(CondNo,incidx);
        end
    end
end

%% regress the factor from each row
resid_st_collect = NaN(size(GM_coords,1),length(subjectlist));
for rowid = 1:size(st_collect,1)
    Yori = st_collect(rowid,:)';
    beta = regress(Yori, [ones(length(factor),1) factor]);
    Yhat = [ones(length(factor),1) factor]*beta;
    residuals = Yori - Yhat;
    resid_st_collect(rowid,:) = residuals';
end



%% load _BfMRIsessiondata.mats to add factor regressed as a new conditon
for sn=1:length(subjectlist)
    resid_2inc = [];
    
    a = load([MATPATH, 'mean_', char(subjectlist(sn)), '_BfMRIsessiondata.mat'], 'session_info','st_coords','num_subj_cond','st_evt_list', 'st_datamat');
    newcond_number = length(a.st_evt_list)+1;
       %% edit conditions labels 
    prefix = a.session_info.condition(1,CondNo);
    a.session_info.condition(1, newcond_number) = {[char(prefix) '_ageresid']};
    a.session_info.condition0 = a.session_info.condition;


       %% rename prefix to display ID in analysis
    a.session_info.datamat_prefix = ['mean_',char(subjectlist(sn))];

       %% edit condition counters
    a.session_info.num_conditions  = newcond_number;
    a.session_info.num_conditions0 = newcond_number;

    % update condition variables of condition 3   
    a.st_datamat(newcond_number,:) = zeros(1, numel(a.st_coords));  
    a.session_info.condition_baseline{newcond_number}  = a.session_info.condition_baseline{1}; 
    a.session_info.condition_baseline0{newcond_number} = a.session_info.condition_baseline0{1};

    
    for stid = 1:size(a.st_coords,1)
        GM_inc = GM_coords==a.st_coords(stid);
        resid_2inc = [resid_2inc resid_st_collect(GM_inc,sn)];
    end
     
    
    if find(isnan(resid_2inc))
        disp('Houston we have a problem of more NaNs');
        disp(char(subjectlist(sn)));
    end
    if length(a.st_datamat)~=length(resid_2inc)
        disp('Houston we have a problem of length mismatch');
        dist(char(subjectlist(sn)));
    else
        a.st_datamat(newcond_number,:) = resid_2inc;
    end
    
    % num_subj_cond AND st_evt_list: ones or numbers = count of conditions
    a.num_subj_cond = [a.num_subj_cond,1];
    a.st_evt_list   = [a.st_evt_list,newcond_number];
        %% save new data file
    save ([MATPATH, 'mean_', char(subjectlist(sn)), '_BfMRIsessiondata.mat'], '-struct', 'a', '-append');

end
end
end
