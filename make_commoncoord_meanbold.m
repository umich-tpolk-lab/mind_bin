function make_commoncoord_meanbold(subject,task)
%% 5th pre-step for PLS.
% fill matrix with masked mean values for various condtions, runs and
% blocks
%% Initiate folder paths
BASEPATH ='/nfs/tpolk/mind/boldvariability/placebo/';
MEANPATH = ([BASEPATH,task,'/pls/mean_datamats/']);

%% Load common set of coordiants
load ([BASEPATH, task, '/pls/',subject,'_coords_EVAL.mat'], 'final_coords');

    
    %% Change mean file
    
%this loads a subject's sessiondata file.
a = load([MEANPATH, 'mean_', subject, '_BfMRIsessiondata.mat']);

%replace fields with correct info.
a.session_info.datamat_prefix= (['mean_commoncoord_' subject]);
[~,fidx] = intersect(a.st_coords,final_coords);
a.st_coords = final_coords;
a.st_datamat =  a.st_datamat(:,fidx);

% save data
save([MEANPATH, a.session_info.datamat_prefix],'-struct','a','-mat');
disp ([subject ' done!'])
clear a
end