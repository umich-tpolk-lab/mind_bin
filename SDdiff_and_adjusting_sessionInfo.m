function SDdiff_and_adjusting_sessionInfo (subjectname,taskname,cond1,cond2)
%% Alter PLS pre file info/content to match 3 conditions

%% Init folder paths and variables
BASEPATH ='/nfs/tpolk/mind/boldvariability/placebo/';
MATPATH = ([BASEPATH,taskname,'/pls/sd_datamats/']);

%% load _BfMRIsessiondata.mats variables to be changed 

try
  a = load([MATPATH, 'SD_', subjectname, '_BfMRIsessiondata.mat'], 'session_info','st_coords','num_subj_cond','st_evt_list', 'st_datamat');
  catch ME
  disp (ME.message)
end
   
   

   
   %% edit conditions labels  
a.session_info.condition(1,1) = {cond1};
a.session_info.condition(1,2) = {cond2};
a.session_info.condition(1,3) = {'fix'};
a.session_info.condition(1,4) = {[cond2,'-',cond1]};
%a.session_info.condition(1,5) = {['avg',cond2,'_',cond1,'-fix']};

a.session_info.condition0 = a.session_info.condition;

   
   %% rename prefix to display ID in analysis
a.session_info.datamat_prefix = ['SD_',subjectname];
     
   %% edit condition counters
a.session_info.num_conditions  = 4;%5;
a.session_info.num_conditions0 = 4;%5;

% update condition variables of condition 3   
a.st_datamat(4,:) = zeros(1, numel(a.st_coords));  
a.session_info.condition_baseline{4}  = a.session_info.condition_baseline{1}; 
a.session_info.condition_baseline0{4} = a.session_info.condition_baseline0{1};

%a.st_datamat(5,:) = zeros(1, numel(a.st_coords));  
%a.session_info.condition_baseline{5}  = a.session_info.condition_baseline{1}; 
%a.session_info.condition_baseline0{5} = a.session_info.condition_baseline0{1};

% compute SD BOLD change score (here 2 - 1)
a.st_datamat(4,:) = a.st_datamat(2,:) - a.st_datamat(1,:);
%a.st_datamat(5,:) = (a.st_datamat(1,:) + a.st_datamat(2,:))/2 - a.st_datamat(3,:);

% num_subj_cond AND st_evt_list: ones or numbers = count of conditions
a.num_subj_cond = [1,1,1,1];%,1];
a.st_evt_list   = [1,2,3,4];%,5];



    %% save new data file
save ([MATPATH, 'SD_', subjectname, '_BfMRIsessiondata.mat'], '-struct', 'a', '-append');

end
