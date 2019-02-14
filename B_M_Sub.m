%This script calculates data that should be flagged in both behavioral and
%motion data.  It organizes it by field (behavioral flags for all subjects
%followed by motion flags for all subjects).  It is called by another
%script so that its results are "published" as a pdf, with the final tables
%being printed out onto pdf pages. 

%This script is the same as the script B_M_Sub.m until line 751.

%This just stops warnings from printing. 
warning('off','all')

%This limits the number of decimal places to two (for this data).
format shortg
% set current directory to where the mastersheet (behavioral data) is
% located.  This section is for flagging behavioral data.  
cd /nfs/tpolk/mind/data/mastersheet;

%Read in the mastersheet and save it as the table "Master".
Master = readtable('mindmaster_clean.csv', 'ReadRowNames', true);

%Create another table, "new", which only contains the rows I am interested
%in for this analysis.
new = Master(:,{'Aud_P_Miss', 'Aud_P_Inc', 'Aud_D_Miss', 'Aud_D_Inc', 'Mot_P_Miss', 'Mot_D_Miss', 'Vis_P_Miss', 'Vis_P_Incor', 'Vis_D_Miss', 'Vis_D_Incor'});

%try just indicated that it it doesn't work its ok, keep going.  I am just
%changing the format of these columns from string to double.  I do this one
%column at a time.
try
new.Aud_P_Miss=str2double(new.Aud_P_Miss);
end
try
new.Aud_P_Inc=str2double(new.Aud_P_Inc);
end
try
new.Aud_D_Miss=str2double(new.Aud_D_Miss);
end
try
new.Aud_D_Inc=str2double(new.Aud_D_Inc);
end
try
new.Mot_P_Miss=str2double(new.Mot_P_Miss);
end
try
new.Mot_D_Miss=str2double(new.Mot_D_Miss);
end
try
new.Vis_P_Miss=str2double(new.Vis_P_Miss);
end
try
new.Vis_P_Incor=str2double(new.Vis_P_Incor);
end
try
new.Vis_D_Miss=str2double(new.Vis_D_Miss);
end
try
new.Vis_D_Incor=str2double(new.Vis_D_Incor);
end

new_mind2 = new;
new = new(1:47, :);
new_mind2.Aud_D_Miss = [];
new_mind2.Aud_D_Inc = [];
new_mind2.Mot_D_Miss = [];
new_mind2.Vis_D_Miss = [];
new_mind2.Vis_D_Incor = [];
new_mind2.Properties.VariableNames = ({'Aud_Miss2', 'Aud_Inc2', 'Mot_Miss2', 'Vis_Miss2', 'Vis_Inc2'});
final4 = new_mind2;


% This creates new columns to contain TOTAL values (placebo session plus
% drug session).  This gives TOTAL number of misses and incorrects for
% audtiory, motor (there is no incorrect) and visual. 

new.Aud_Miss = (new.Aud_P_Miss + new.Aud_D_Miss);
new.Aud_Inc = (new.Aud_P_Inc + new.Aud_D_Inc);
new.Mot_Miss = (new.Mot_P_Miss + new.Mot_D_Miss);
new.Vis_Miss = (new.Vis_P_Miss + new.Vis_D_Miss);
new.Vis_Inc = (new.Vis_P_Incor + new.Vis_D_Incor);

% I create a new table, final2, which is just the columns that I created
% above (only total values).
final2 = new(:,{'Aud_Miss', 'Aud_Inc', 'Mot_Miss', 'Vis_Miss', 'Vis_Inc'});

%Next I create variables (like Aud_Miss_M) to save the mean of each column 
%in the above data set.  I am finding the mean of each data set so later on
% I can calculate outliers. 

Aud_Miss_M = nanmean(final2.Aud_Miss);
Aud_Inc_M = nanmean(final2.Aud_Inc);
Mot_Miss_M = nanmean(final2.Mot_Miss);
Vis_Miss_M = nanmean(final2.Vis_Miss);
Vis_Inc_M = nanmean(final2.Vis_Inc);

Aud_Miss_M2 = nanmean(final4.Aud_Miss2);
Aud_Inc_M2 = nanmean(final4.Aud_Inc2);
Mot_Miss_M2 = nanmean(final4.Mot_Miss2);
Vis_Miss_M2 = nanmean(final4.Vis_Miss2);
Vis_Inc_M2 = nanmean(final4.Vis_Inc2);

% Then create variables to save the standard deviation of each column in
% the data set, again to calculate outliers later on.

Aud_Miss_SD = nanstd(final2.Aud_Miss);
Aud_Inc_SD = nanstd(final2.Aud_Inc);
Mot_Miss_SD = nanstd(final2.Mot_Miss);
Vis_Miss_SD = nanstd(final2.Vis_Miss);
Vis_Inc_SD = nanstd(final2.Vis_Inc);

Aud_Miss_SD2 = nanstd(final4.Aud_Miss2);
Aud_Inc_SD2 = nanstd(final4.Aud_Inc2);
Mot_Miss_SD2 = nanstd(final4.Mot_Miss2);
Vis_Miss_SD2 = nanstd(final4.Vis_Miss2);
Vis_Inc_SD2 = nanstd(final4.Vis_Inc2);

% rename final2 to new3. 
new3 = final2; 
new4 = final4;

% Now I calculate a z score for each column.  By using each individuals
% value (Aud.Miss), then subtracting the mean value (Aud_Miss_M) and
% dividing by the standard deviation (Aud_Miss_SD), I will get a zscore
% corresponding to each subject in each field (aud/motor/visual in misses
% and incorrects).  

new3.Aud_Miss_z = (new3.Aud_Miss - Aud_Miss_M)/Aud_Miss_SD;
new3.Aud_Inc_z = (new3.Aud_Inc - Aud_Inc_M)/Aud_Inc_SD;
new3.Mot_Miss_z = (new3.Mot_Miss - Mot_Miss_M)/Mot_Miss_SD;
new3.Vis_Miss_z = (new3.Vis_Miss - Vis_Miss_M)/Vis_Miss_SD;
new3.Vis_Inc_z = (new3.Vis_Inc - Vis_Inc_M)/Vis_Inc_SD;

new4.Aud_Miss_z2 = (new4.Aud_Miss2 - Aud_Miss_M2)/Aud_Miss_SD2;
new4.Aud_Inc_z2 = (new4.Aud_Inc2 - Aud_Inc_M2)/Aud_Inc_SD2;
new4.Mot_Miss_z2 = (new4.Mot_Miss2 - Mot_Miss_M2)/Mot_Miss_SD2;
new4.Vis_Miss_z2 = (new4.Vis_Miss2 - Vis_Miss_M2)/Vis_Miss_SD2;
new4.Vis_Inc_z2 = (new4.Vis_Inc2 - Vis_Inc_M2)/Vis_Inc_SD2;


% I create a new table, A_M_T which is the data frame new3 but only with
% columns Aud_Miss and Aud_Miss_z. 
A_M_T= new3(:, {'Aud_Miss', 'Aud_Miss_z'});
A_M_T2= new4(:, {'Aud_Miss2', 'Aud_Miss_z2'});
%I want to delete anything that is NOT an outlier.  For this scenario, we
%consider anything greater than two standard deviations from the mean an
%outlier (z score is greater than 2 or less than -2).  
toDelete = (A_M_T.Aud_Miss_z < 2 & A_M_T.Aud_Miss_z > -2);
toDelete2 = (A_M_T2.Aud_Miss_z2 < 2 & A_M_T2.Aud_Miss_z2 > -2);

% I then delete non-outliers from my data set A_M_T.
A_M_T(toDelete, :) = [];
A_M_T2(toDelete2, :) = [];

%Create a column "Subject", which is the value in rownames.  For this data
%set, the rownames are subject IDs, so I want a column with these
%displayed.
A_M_T.Subjects = A_M_T.Properties.RowNames;
A_M_T2.Subjects = A_M_T2.Properties.RowNames;

%Change the format of the column "Subject" to character.
A_M_T.Subjects = char(A_M_T.Subjects);
A_M_T2.Subjects = char(A_M_T2.Subjects);


%The 5 steps I did above are then repeated for auditory incorrect, motor
%miss, visual miss, and visual incorrect. 

A_I_T= new3(:, {'Aud_Inc', 'Aud_Inc_z'});
toDelete = (A_I_T.Aud_Inc_z < 2 & A_I_T.Aud_Inc_z > -2);
A_I_T(toDelete, :) = [];
A_I_T.Subjects = A_I_T.Properties.RowNames;
A_I_T.Subjects = char(A_I_T.Subjects);

A_I_T2= new4(:, {'Aud_Inc2', 'Aud_Inc_z2'});
toDelete2 = (A_I_T2.Aud_Inc_z2 < 2 & A_I_T2.Aud_Inc_z2 > -2);
A_I_T2(toDelete2, :) = [];
A_I_T2.Subjects = A_I_T2.Properties.RowNames;
A_I_T2.Subjects = char(A_I_T2.Subjects);

M_M_T= new3(:, {'Mot_Miss', 'Mot_Miss_z'});
toDelete = (M_M_T.Mot_Miss_z < 2 & M_M_T.Mot_Miss_z > -2);
M_M_T(toDelete, :) = [];
M_M_T.Subjects = M_M_T.Properties.RowNames;
M_M_T.Subjects = char(M_M_T.Subjects);

M_M_T2= new4(:, {'Mot_Miss2', 'Mot_Miss_z2'});
toDelete2 = (M_M_T2.Mot_Miss_z2 < 2 & M_M_T2.Mot_Miss_z2 > -2);
M_M_T2(toDelete2, :) = [];
M_M_T2.Subjects = M_M_T2.Properties.RowNames;
M_M_T2.Subjects = char(M_M_T2.Subjects);

V_M_T= new3(:, {'Vis_Miss', 'Vis_Miss_z'});
toDelete = (V_M_T.Vis_Miss_z < 2 & V_M_T.Vis_Miss_z > -2);
V_M_T(toDelete, :) = [];
V_M_T.Subjects = V_M_T.Properties.RowNames;
V_M_T.Subjects = char(V_M_T.Subjects);

V_M_T2= new4(:, {'Vis_Miss2', 'Vis_Miss_z2'});
toDelete2 = (V_M_T2.Vis_Miss_z2 < 2 & V_M_T2.Vis_Miss_z2 > -2);
V_M_T2(toDelete2, :) = [];
V_M_T2.Subjects = V_M_T2.Properties.RowNames;
V_M_T2.Subjects = char(V_M_T2.Subjects);

V_I_T= new3(:, {'Vis_Inc', 'Vis_Inc_z'});
toDelete = (V_I_T.Vis_Inc_z < 2 & V_I_T.Vis_Inc_z > -2);
V_I_T(toDelete, :) = [];
V_I_T.Subjects = V_I_T.Properties.RowNames;
V_I_T.Subjects = char(V_I_T.Subjects);

V_I_T2= new4(:, {'Vis_Inc2', 'Vis_Inc_z2'});
toDelete2 = (V_I_T2.Vis_Inc_z2 < 2 & V_I_T2.Vis_Inc_z2 > -2);
V_I_T2(toDelete2, :) = [];
V_I_T2.Subjects = V_I_T2.Properties.RowNames;
V_I_T2.Subjects = char(V_I_T2.Subjects);

%Now that there are data sets for each group containing the outliers, we
%will merge all these tables together to get one table.  The function
%outerjoin can only join two tables at a time, so we have to combine tables
%multiple times to end up with one table.  I join the tables by Subject, so
%values corresponding to the same subject combine in one row when tables
%are merged.

Combine1=outerjoin(A_M_T, A_I_T, 'Keys', 'Subjects', 'MergeKeys', 1);
Combine2=outerjoin(M_M_T, V_M_T, 'Keys', 'Subjects', 'MergeKeys', 1);
Combine3=outerjoin(Combine1, Combine2, 'Keys', 'Subjects', 'MergeKeys', 1);
Combine4=outerjoin(Combine3, V_I_T, 'Keys', 'Subjects', 'MergeKeys', 1);

Combine1_2=outerjoin(A_M_T2, A_I_T2, 'Keys', 'Subjects', 'MergeKeys', 1);
Combine2_2=outerjoin(M_M_T2, V_M_T2, 'Keys', 'Subjects', 'MergeKeys', 1);
Combine3_2=outerjoin(Combine1_2, Combine2_2, 'Keys', 'Subjects', 'MergeKeys', 1);
Combine4_2=outerjoin(Combine3_2, V_I_T2, 'Keys', 'Subjects', 'MergeKeys', 1);

%Combine 4 is my final table. 
%Change the format of Subject to cell array of character vectors.
Combine4.Subjects = cellstr(Combine4.Subjects);
Combine4_2.Subjects = cellstr(Combine4_2.Subjects);

% I set the column Subject as the rownames. 
Combine4.Properties.RowNames = Combine4.Subjects;
Combine4_2.Properties.RowNames = Combine4_2.Subjects;

%Delete the column "Subject".  This does not delte the rownames which
%contain the Subject IDs. 
Combine4.Subjects = [];
Combine4_2.Subjects = [];

% Delete all the columns with the z scores (I only want number of
% incorrect/misses for each subject, not their z scores).
Combine4.Aud_Miss_z = [];
Combine4.Aud_Inc_z = [];
Combine4.Mot_Miss_z = [];
Combine4.Vis_Miss_z = [];
Combine4.Vis_Inc_z = [];

Combine4_2.Aud_Miss_z2 = [];
Combine4_2.Aud_Inc_z2 = [];
Combine4_2.Mot_Miss_z2 = [];
Combine4_2.Vis_Miss_z2 = [];
Combine4_2.Vis_Inc_z2 = [];


%Change the format of Combine4 from table to array, rename it "finalarray".
finalarray = table2array(Combine4);
finalarray2 = table2array(Combine4_2);

%Change any NaNs to 0.
finalarray(isnan(finalarray))=0;
finalarray2(isnan(finalarray2))=0;

%Create the variable "varnames" which contains how I want the columns to be
%named.
varnames = {'Aud_Miss',
    'Aud_Inc',
    'Mot_Miss',
    'Vis_Miss',
    'Vis_Inc'};
varnames = varnames';

varnames2 = {'Aud_Miss',
    'Aud_Inc',
    'Mot_Miss',
    'Vis_Miss',
    'Vis_Inc'
	'Aud_Miss2',
    'Aud_Inc2',
    'Mot_Miss2',
    'Vis_Miss2',
    'Vis_Inc2'};
varnames2 = varnames2';





%Create variable "Subject" which is extracted from the row names. 
Subject = Combine4.Properties.RowNames;
Subject2 = Combine4_2.Properties.RowNames;

% Create a table "NT", from the arrary finalarray, and use varnames as the
% new Variable Names (column headers" and label RowNames as Subject.
NT = array2table(finalarray, 'VariableNames',varnames,'RowNames', Subject);
NT2 = array2table(finalarray2, 'VariableNames',varnames,'RowNames', Subject2);
NT.Sub = Subject;
NT.Sub = char(NT.Sub);
NT2.Sub = Subject2;
NT2.Sub = char(NT2.Sub);
NT2.Subs = NT2.Sub(:,6:8);
NT2.Subs = str2num(NT2.Subs);
todeletesubs = (NT2.Subs < 155);
NT2(todeletesubs, :) = [];
NT2.Subs = [];

Allsubs = outerjoin(NT, NT2, 'Keys', 'Sub', 'MergeKeys', 1);
Allsubs.Sub = cellstr(Allsubs.Sub);
Allsubs.Properties.RowNames = Allsubs.Sub;
Subject = Allsubs.Properties.RowNames;
Allsubs.Sub = [];
A = table2array(Allsubs);
A(isnan(A))=0;
NT = array2table(A, 'VariableNames',varnames2,'RowNames', Subject);
NT.Aud_MissF = (NT.Aud_Miss + NT.Aud_Miss2);
NT.Aud_IncF = (NT.Aud_Inc + NT.Aud_Inc2);
NT.Mot_MissF = (NT.Mot_Miss + NT.Mot_Miss2);
NT.Vis_MissF = (NT.Vis_Miss + NT.Vis_Miss2);
NT.Vis_IncF = (NT.Vis_Inc + NT.Vis_Inc2);
NT.Aud_Miss2 = [];
NT.Aud_Inc2 = [];
NT.Mot_Miss2 = [];
NT.Vis_Miss2 = [];
NT.Vis_Inc2 = [];
NT.Aud_Miss = [];
NT.Aud_Inc = [];
NT.Mot_Miss = [];
NT.Vis_Miss = [];
NT.Vis_Inc = [];


%Rename NT to AllNT.
AllNT = NT;
AllNT.Properties.VariableNames = varnames;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This section is for flagging the motion data. 

%Set the currecnt directory to folder containing all subjects. 
cd /nfs/tpolk/mind/subjects/

%Rename the directory to "files".
files = dir;

%Create the variable directoryNames which essentially is the subject name
%of all subjects in that folder.
directoryNames = {files([files.isdir]).name};

%Reset directoyNames to only be subjects that appear in the Altered_Figs
%folder. 
directoryNames = directoryNames(~ismember(directoryNames,{'.','..', 'Figures', 'Altered_Figs'}));

%Now set directoryNames to also be called Subject since this is the subject list
%we will use. 
Subject = directoryNames;

%Create a matrix called flags. 
Flags = [];

%This next very large section finds any motion outliers for multiple situations.
%It examines motion graphs for drug and placebo sessions, for auditory,
%connectivity, motor, visual and tactile. Each section follows a very
%similar format, values are just saved as different variable names.  D is
%for drug, P is for placebo, AUD is for auditory and so on. 


%Essentially, this first line says "for every subject in this folder..."
for  i=1:length(directoryNames)
	
	%set the variable sub to be the subject ID.
    sub = directoryNames{i};
	
	%Create a variable, "Drug_Auditory" which is the directory path to the
	%Drug Auditory motion data. 
    Drug_Auditory = ['/nfs/tpolk/mind/subjects/',sub,'/drug/func/auditory/run_01'];
	
	%Set the current directory to the path to the drug auditory data. 
    try cd(Drug_Auditory);
		
	%The motion data is saved as "realign.dat".  I want to import this data
	%and save it as teh variable D_AUD.	
	D_AUD= importdata('realign.dat');
	
	%The first three columns correspond to rotation (x, y, z) and the next
	% three columns correspond to translation (x, y, z).  The rotation 
	% values in this data set are in degrees, and there are positive and
	%negative values of motion.  I just want the absolute value, and I want
	%these vlaues in radians.  By using abs() I get absolute value, and by
	%mulitplying by 57.2958 the values are then in radians. The next three
	%columns (for translation) are in mm which is okay.
	D_AUD_R = abs((D_AUD(:,1:3))*57.2958);
	
	%DA_L1 corresponds to the x-direction rotation. 
    DA_L1 = D_AUD_R(:,1);
	%DA_L2 corresponds to the y-direction rotation. 
    DA_L2 = D_AUD_R(:,2);
	%DA_L3 corresponds to the z-direction rotation.
    DA_L3 = D_AUD_R(:,3);
	%DA_T3 is jsut the total rotation data.
    DA_T3 = abs(D_AUD_R(:,1:3));
	%DA_L4 corresponds to the x-direction translation.
    DA_L4 = abs(D_AUD(:,4));
	%DA_L5 corresponds to the y-direction translation.
    DA_L5 = abs(D_AUD(:,5));
	%DA_L6 corresponds to the z-direction translation.
    DA_L6 = abs(D_AUD(:,6));
	%DA_T6 is jsut the total translation data.
    DA_T6 = abs(D_AUD(:,4:6));
	
	%Below are the limits we want to set.  These were decided by Dr. Polk.
	% If rotation, in any direction, is more than 2.86479 radians, it will
	% be considered an outlier.  If translation, in any direction, is
	% greater than 2mm it is considered an outlier. 
    Lim1 = 2.86479;
    Lim2 = 2.86479;
    Lim3 = 2.86479;
    Lim4 = 2;
    Lim5 = 2;
    Lim6 = 2;
    
	%Below is where I calculate any rotation outliers.  If any of the
	%rotation values (xdirection = DA_L1, ydirection=DA_L2,
	%zdirection=DA_L3) are greater than the rotation limit (Lim1, Lim2,
	%Lim3), then I just want whatever motion value is the LARGEST of the
	%data.  This is found by getting the maximum of all the rotation data
	%(DA_T3).  I save this max value as the variable R_DAUD and round it to
	%two decimal places. 
    if any(DA_L1 > Lim1 | DA_L2 > Lim2 | DA_L3 > Lim3)
    R_DAUD = max(max(abs(DA_T3)));
	 R_DAUD = round(R_DAUD,2, 'decimals');
	
	% If none of the rotation values are greater than the limit, than
	% R_DAUD is set as 0 instead. 
    else
    R_DAUD = 0.00;
	end
    
	% Same idea, but for translation. If any of the
	%translation values (xdirection = DA_L4, ydirection=DA_L5,
	%zdirection=DA_L6) are greater than the rotation limit (Lim4, Lim5,
	%Lim6), then I just want whatever motion value is the LARGEST of the
	%data.  This is found by getting the maximum of all the translation data
	%(DA_T6).  I save this max value as the variable T_DAUD and round it to
	%two decimal places. 
    if any(DA_L4 > Lim4 | DA_L5 > Lim5 | DA_L6 > Lim6)
    T_DAUD  = max(max(abs(DA_T6)));
	 T_DAUD = round(T_DAUD,2, 'decimals');
	
	% If none of the translation values are greater than the limit, than
	% T_DAUD is set as 0 instead.
    else
    T_DAUD = 0.00;
	end
	
	%Catch ME basically means respond to some exception.  If there is
	%something weird (data is wrong or something like that), then just set
	%the two variables R_DAUD and T_DAUD to NaN.
	catch ME
		R_DAUD=NaN;
		T_DAUD=NaN;
	end
	
    %This basic principal of separating and calculating values greater than
    %the limits is repeated.  The same procedure is done for drug
    %connectivity, drug motor, drug visual, drug tactile, then placebo auditoy, placebo
    %connectivity, placebo motor, placebo visual and placebo tactile.  Only the directory 
	% pathvariable names change.  This is repeated until line 665.

    Drug_Connectivity = ['/nfs/tpolk/mind/subjects/',sub,'/drug/func/connectivity/run_01'];
    try cd( Drug_Connectivity);
	D_CON = importdata('realign.dat');
    D_CON_R = abs((D_CON(:,1:3))*57.2958);
    DC_L1 = D_CON(:,1);
    DC_L2 = D_CON(:,2);
    DC_L3 = D_CON(:,3);
    DC_T3 = abs(D_CON_R(:,1:3));
    DC_L4 = abs(D_CON(:,4));
    DC_L5 = abs(D_CON(:,5));
    DC_L6 = abs(D_CON(:,6));
    DC_T6 = abs(D_CON(:,4:6));
 
    if any(DC_L1 > Lim1 | DC_L2 > Lim2 | DC_L3 > Lim3)
    R_DCON = max(max(abs(DC_T3)));
	 R_DCON = round(R_DCON,2, 'decimals');
	
    else
    R_DCON = 0.00;
    end
    
    if any(DC_L4 > Lim4 | DC_L5 > Lim5 | DC_L6 > Lim6)
    T_DCON  = max(max(abs(DC_T6)));
	 T_DCON = round(T_DCON,2, 'decimals');
	
     else
    T_DCON = 0.00;
	end
	
	catch ME
		R_DCON=NaN;
		T_DCON=NaN;
	end
	
    
    
    Drug_Motor = ['/nfs/tpolk/mind/subjects/',sub,'/drug/func/motor/run_01'];
    try cd( Drug_Motor);
	D_MOT = importdata('realign.dat');
     D_MOT_R = abs((D_MOT(:,1:3))*57.2958);
    DM_L1 = D_MOT_R(:,1);
    DM_L2 = D_MOT_R(:,2);
    DM_L3 = D_MOT_R(:,3);
    DM_T3 = D_MOT_R(:,1:3);
    DM_L4 = abs(D_MOT(:,4));
    DM_L5 = abs(D_MOT(:,5));
    DM_L6 = abs(D_MOT(:,6));
    DM_T6 = abs(D_MOT(:,4:6));
    
    
 
    if any(DM_L1 > Lim1 | DM_L2 > Lim2 | DM_L3 > Lim3)
    R_DMOT = max(max(abs(DM_T3)));
	 R_DMOT = round(R_DMOT,2, 'decimals');
	
    else
    R_DMOT = 0.00;
    end
    
    if any(DM_L4 > Lim4 | DM_L5 > Lim5 | DM_L6 > Lim6)
    T_DMOT  = max(max(abs(DM_T6)));
	T_DMOT = round(T_DMOT,2, 'decimals');
	
     else
    T_DMOT = 0.00;
    end
    
	catch ME
		R_DMOT=NaN;
		T_DMOT=NaN;
	end
    
     Drug_Tactile = ['/nfs/tpolk/mind/subjects/',sub,'/drug/func/tactile/run_01'];
     try cd( Drug_Tactile);
	D_TAC = importdata('realign.dat');
     D_TAC_R = abs((D_TAC(:,1:3))*57.2958);
    DT_L1 = D_TAC_R(:,1);
    DT_L2 = D_TAC_R(:,2);
    DT_L3 = D_TAC_R(:,3);
    DT_T3 = D_TAC_R(:,1:3);
    DT_L4 = abs(D_TAC(:,4));
    DT_L5 = abs(D_TAC(:,5));
    DT_L6 = abs(D_TAC(:,6));
    DT_T6 = abs(D_TAC(:,4:6));
    
    
 
    if any(DT_L1 > Lim1 | DT_L2 > Lim2 | DT_L3 > Lim3)
    R_DTAC = max(max(abs(DT_T3)));
	R_DTAC = round(R_DTAC,2, 'decimals');
	
    else
    R_DTAC = 0.00;
    end
    
    if any(DT_L4 > Lim4 | DT_L5 > Lim5 | DT_L6 > Lim6)
    T_DTAC  = max(max(abs(DT_T6)));
	T_DTAC = round(T_DTAC,2, 'decimals');
	
     else
    T_DTAC = 0.00;
	end
	
	catch ME
		R_DTAC=NaN;
		T_DTAC=NaN;
	end
    
    
     Drug_Visual = ['/nfs/tpolk/mind/subjects/',sub,'/drug/func/visual/run_01'];
     try cd( Drug_Visual);
	D_VIS = importdata('realign.dat');
     D_VIS_R = abs((D_VIS(:,1:3))*57.2958);
    DV_L1 = D_VIS_R(:,1);
    DV_L2 = D_VIS_R(:,2);
    DV_L3 = D_VIS_R(:,3);
    DV_T3 = D_VIS_R(:,1:3);
    DV_L4 = abs(D_VIS(:,4));
    DV_L5 = abs(D_VIS(:,5));
    DV_L6 = abs(D_VIS(:,6));
    DV_T6 = abs(D_VIS(:,4:6));
    
    
 
    if any(DV_L1 > Lim1 | DV_L2 > Lim2 | DV_L3 > Lim3)
    R_DVIS = max(max(abs(DV_T3)));
	 R_DVIS = round(R_DVIS,2, 'decimals');

    else
    R_DVIS = 0.00;
    end
    
    if any(DV_L4 > Lim4 | DV_L5 > Lim5 | DV_L6 > Lim6)
    T_DVIS  = max(max(abs(DV_T6)));
	 T_DVIS = round(T_DVIS,2, 'decimals');
	
     else
    T_DVIS = 0.00;
	end
	
	catch ME
		R_DVIS=NaN;
		T_DVIS=NaN;
	end
    
  
    Placebo_Auditory = ['/nfs/tpolk/mind/subjects/',sub,'/placebo/func/auditory/run_01'];
     try cd(Placebo_Auditory);
		 P_AUD = importdata('realign.dat');
     P_AUD_R = abs((P_AUD(:,1:3))*57.2958);
    PA_L1 = P_AUD_R(:,1);
    PA_L2 = P_AUD_R(:,2);
    PA_L3 = P_AUD_R(:,3);
    PA_T3 = P_AUD_R(:,1:3);
    PA_L4 = abs(P_AUD(:,4));
    PA_L5 = abs(P_AUD(:,5));
    PA_L6 = abs(P_AUD(:,6));
    PA_T6 = abs(P_AUD(:,4:6));
    
    
    if any(PA_L1 > Lim1 | PA_L2 > Lim2 | PA_L3 > Lim3)
    R_PAUD = max(max(abs(PA_T3)));
	R_PAUD = round(R_PAUD,2, 'decimals');
	
    else
    R_PAUD = 0.00;
    end
    
    if any(PA_L4 > Lim4 | PA_L5 > Lim5 | PA_L6 > Lim6)
    T_PAUD  = max(max(abs(PA_T6)));
	T_PAUD = round(T_PAUD,2, 'decimals');

	else
    T_PAUD = 0.00;
    end
    
	catch ME
		R_PAUD=NaN;
		T_PAUD=NaN;
	end
    
    Placebo_Connectivity = ['/nfs/tpolk/mind/subjects/',sub,'/placebo/func/connectivity/run_01'];
     try cd(Placebo_Connectivity);
		 P_CON = importdata('realign.dat');
    P_CON_R = abs((P_CON(:,1:3))*57.2958);
    PC_L1 = P_CON_R(:,1);
    PC_L2 = P_CON_R(:,2);
    PC_L3 = P_CON_R(:,3);
    PC_T3 = P_CON_R(:,1:3);
    PC_L4 = abs(P_CON(:,4));
    PC_L5 = abs(P_CON(:,5));
    PC_L6 = abs(P_CON(:,6));
    PC_T6 = abs(P_CON(:,4:6));
    
 
    if any(PC_L1 > Lim1 | PC_L2 > Lim2 | PC_L3 > Lim3)
    R_PCON = max(max(abs(PC_T3)));
	R_PCON = round(R_PCON,2, 'decimals');
	
	else
    R_PCON = 0.00;
    end
    
    if any(PC_L4 > Lim4 | PC_L5 > Lim5 | PC_L6 > Lim6)
    T_PCON  = max(max(abs(PC_T6)));
	T_PCON = round(T_PCON,2, 'decimals');
	
     else
    T_PCON = 0.00;
	end
	
	catch ME
		R_PCON=NaN;
		T_PCON=NaN;
	end
    
  
    
    Placebo_Motor = ['/nfs/tpolk/mind/subjects/',sub,'/placebo/func/motor/run_01'];
     try cd(Placebo_Motor);
		 P_MOT = importdata('realign.dat');
    P_MOT_R = abs((P_MOT(:,1:3))*57.2958);
    PM_L1 = P_MOT_R(:,1);
    PM_L2 = P_MOT_R(:,2);
    PM_L3 = P_MOT_R(:,3);
    PM_T3 = P_MOT_R(:,1:3);
    PM_L4 = abs(P_MOT(:,4));
    PM_L5 = abs(P_MOT(:,5));
    PM_L6 = abs(P_MOT(:,6));
    PM_T6 = abs(P_MOT(:,4:6));
    
    if any(PM_L1 > Lim1 | PM_L2 > Lim2 | PM_L3 > Lim3)
    R_PMOT = max(max(abs(PM_T3)));
	R_PMOT = round(R_PMOT,2, 'decimals');

    else
    R_PMOT = 0.00;
    end
    
    if any(PM_L4 > Lim4 | PM_L5 > Lim5 | PM_L6 > Lim6)
    T_PMOT  = max(max(abs(PM_T6)));
	T_PMOT = round(T_PMOT,2, 'decimals');
	
     else
    T_PMOT = 0.00;
	end
	
	catch ME
		R_PMOT=NaN;
		T_PMOT=NaN;
	end
    
    
    Placebo_Tactile = ['/nfs/tpolk/mind/subjects/',sub,'/placebo/func/tactile/run_01'];
      try cd(Placebo_Tactile);
		   P_TAC = importdata('realign.dat');
    P_TAC_R = abs((P_TAC(:,1:3))*57.2958);
    PT_L1 = P_TAC_R(:,1);
    PT_L2 = P_TAC_R(:,2);
    PT_L3 = P_TAC_R(:,3);
    PT_T3 = P_TAC_R(:,1:3);
    PT_L4 = abs(P_TAC(:,4));
    PT_L5 = abs(P_TAC(:,5));
    PT_L6 = abs(P_TAC(:,6));
    PT_T3 = abs(P_TAC(:,4:6));
    
    if any(PT_L1 > Lim1 | PT_L2 > Lim2 | PT_L3 > Lim3)
    R_PTAC = max(max(abs(PT_T3)));
	R_PTAC = round(R_PTAC,2, 'decimals');
	
    else
    R_PTAC = 0.00;
    end
    
    if any(PT_L4 > Lim4 | PT_L5 > Lim5 | PT_L6 > Lim6)
    T_PTAC  = max(max(abs(PT_T6)));
	T_PTAC = round(T_PTAC,2, 'decimals');
	
     else
    T_PTAC = 0.00;
	end
	
	catch ME
		R_PTAC=NaN;
		T_PTAC=NaN;
	end
    
   

    
    Placebo_Visual = ['/nfs/tpolk/mind/subjects/',sub,'/placebo/func/visual/run_01'];
     try cd(Placebo_Visual);
	P_VIS = importdata('realign.dat');
    P_VIS_R = abs((P_VIS(:,1:3))*57.2958);
    PV_L1 = P_VIS_R(:,1);
    PV_L2 = P_VIS_R(:,2);
    PV_L3 = P_VIS_R(:,3);
    PV_T3 = P_VIS_R(:,1:3);
    PV_L4 = abs(P_VIS(:,4));
    PV_L5 = abs(P_VIS(:,5));
    PV_L6 = abs(P_VIS(:,6));
    PV_T6 = abs(P_VIS(:,4:6));
    
    if any(PV_L1 > Lim1 | PV_L2 > Lim2 | PV_L3 > Lim3)
    R_PVIS = max(max(abs(PV_T3)));
	R_PVIS  = round(R_PVIS,2, 'decimals');

    else
    R_PVIS = 0.00;
    end
    
    if any(PV_L4 > Lim4 | PV_L5 > Lim5 | PV_L6 > Lim6)
    T_PVIS  = max(max(abs(PV_T6)));
	T_PVIS  = round(T_PVIS,2, 'decimals');
     else
    T_PVIS = 0.00;
    end
	catch ME
		R_PVIS=NaN;
		T_PVIS=NaN;
	 end
   
	% Now the motion outliers have been found for all situations. 

    %Create empty matrix called "matrix".
   matrix = [];
   
   %Fill the matrix with all the varibles we just defined.
   matrix = [matrix R_DAUD T_DAUD R_DCON T_DCON R_DMOT T_DMOT R_DTAC T_DTAC R_DVIS T_DVIS R_PAUD T_PAUD R_PCON T_PCON R_PMOT T_PMOT R_PTAC T_PTAC R_PVIS T_PVIS ];
	
   % Put this matrix into the empty matrix "Flags".
   Flags = [Flags; matrix];
end


%Create "varnames" to contain all the column headers I want to use for the
%flagged motion data.
varnames = {'R_DAUD', 
    'T_DAUD',
    'R_DCON', 
    'T_DCON', 
    'R_DMOT', 
    'T_DMOT', 
    'R_DTAC', 
    'T_DTAC', 
    'R_DVIS', 
    'T_DVIS', 
    'R_PAUD', 
    'T_PAUD', 
    'R_PCON', 
    'T_PCON', 
    'R_PMOT', 
    'T_PMOT', 
    'R_PTAC', 
    'T_PTAC',
    'R_PVIS',
    'T_PVIS'};
    
varnames = varnames';

%Create a table, "FlagFinal" from the matrix "Flags", with the column
%headers set to the variable names I defined above, and the RowNames
%labeled as Subject.

FlagFinal = array2table(Flags, 'VariableNames',varnames,'RowNames', Subject);
%Rename table to AllFlag.

AllFlag = FlagFinal;

%Create a column called Subject which contains the information extracted
%from the rownames (creates a column of Subject IDs).
AllFlag.Subject = AllFlag.Properties.RowNames;

%Recall that All.NT is a table we created of all the behavioral outliers.
%We do the same thing to this dataset where we create a new column,
%Subject, which has all the subject IDs extracted from the row names.
AllNT.Subject = AllNT.Properties.RowNames;

%Combine the two tables, AllNT (behavioral flags) and AllFlag (motion
%flags) by Subject into a new table called "Combine". 
Combine=outerjoin(AllNT, AllFlag, 'Keys', 'Subject', 'MergeKeys', 1);

%Label the Rownames with the Subject column.
Combine.Properties.RowNames = Combine.Subject;

%Delete the column Subject. (Subject ID is preserved in row names).
Combine.Subject = [];

%Create an array, "AllN", by changing the table "Combine" to an array
%format.
AllN = table2array(Combine);

%Set at NaNs in AllN to 0.
AllN(isnan(AllN))=0;

%Create a variable "varnames" which is just the column headers of the table
%"Combine".
varnames = Combine.Properties.VariableNames;

%Create a variable "Subject" which is just the rwo names of the table
%"Combine".
Subject = Combine.Properties.RowNames;

%Create a new table "All" from the array "AllN" with column headers of
%"varnames" and row names of "Subject". This switchin from table to array
%back to array was so that we could change the NaNs to 0.
All = array2table(AllN, 'VariableNames',varnames,'RowNames', Subject);

%Create a new column, "Sum" which sums up all outlier variables.
All.Sum = (All.Aud_Miss + All.Aud_Inc + All.Mot_Miss + All.Vis_Miss + All.Vis_Inc + All.R_DAUD + All.T_DAUD + All.R_DCON + All.T_DCON + All.R_DMOT + All.T_DMOT + All.R_DTAC + All.T_DTAC + All.R_DVIS + All.T_DVIS + All.R_PAUD + All.T_PAUD + All.R_PCON + All.T_PCON + All.R_PMOT + All.T_PMOT + All.R_PTAC + All.T_PTAC + All.R_PVIS + All.T_PVIS);

% Create a cariable "toDelete".  Since you cannot say "Delte if All.Sum
% = 0", I use delete if the sum is less than some very small number.  This
%is so if there are NO outliers, this row is later removed. 
toDelete = All.Sum < 0.0000000000001;

%This deletes any rows where the sum is essentially 0 (no outliers).
All(toDelete, :) = [];

%Delete the Sum row as it is no longer needed. 
All.Sum = [];

%Create a variable "Subject" which is just the row names of the table
%"All".
Subject = All.Properties.RowNames;

%Rename All to All1
All1 = All;

%Create a new column, Subject, which extracts subject IDs from the row
%names.
All1.Subject = All1.Properties.RowNames;

%Change format of Subject to character. 
All1.Subject = char(All1.Subject);

%Create a new column called ID which is just the last three characters
%of Subject (i.e. Subject has mindo100, so ID is just 100)
All1.ID = All1.Subject(:,6:8);

%Create a new table, All2 which is All1 but sorted by ID, that
%is, in numerical order.
All2 = sortrows(All1,'ID');

%Delte the ID column. 
All2.ID = [];

%Delte the Subject column. 
All2.Subject = [];

%Rename All2 to YourTable.
YourTable = All2;

% In this next part we are essentially switching the position of variable
% names and subject name.  The row names will be the variables (like
% Aud_Miss) and the columns will be individual subjects. 

%First, create an array YourArray by turning the table (YourTable) to an
%array.
YourArray = table2array(YourTable);

% This creates a new Table, (YourNewTable) by switching columns and rows of
% YourArray.
YourNewTable = array2table(YourArray.');

%Name the rows of YourNewTable with the variable names of your original
%table, YourTable.
YourNewTable.Properties.RowNames = YourTable.Properties.VariableNames;

%Name the columns(VariableNames) of YourNewTable with the row names of your original
%table, YourTable.
YourNewTable.Properties.VariableNames = YourTable.Properties.RowNames;

%Create a variable "Subject" which is extracted from the rows of table
%All2.
Subjects = All2.Properties.RowNames;


%Now that we have a big table where each column is an individual subject,
%we are ready to display, or print, individual subject outlier tables.  The
%disp() function means this tables will be printed to a pdf when this
%script is run by an outside script. 

%This first line is essentially a header.  The pdf will print the text
%"Individual Subject Flags".  The next disp() with a bunch of spaces just
%enters a line between the header and the table, for aesethic appeal. 

disp('Individual Subject Flags')
disp('                                                                                      ')

%This for loop is run for each individual subject in the variable
%"Subject".  Essentially, it will display a small table for each subject,
%containing any and all outliers. So, "for every subject in Subject..."
for  i=1:length(Subjects);
	
	%Create a variable "sub" which is just the subject name. 
    sub = Subjects{i};
	
	%Extract the column of YourNewTable which is titled with the subject
	%ID, and create a new small table of just this subject called Tnew.
    Tnew = YourNewTable(:, {sub});
	
	%This "toDelete" essentially deletes any row's that contain a 0 (there
	%is no outlier).  Since you can't say equal to 0, I make the
	%requirement extremely small. 
    toDelete = Tnew{:, 1} < 0.0000000000001;
	
	% Delete any rows that qualify for toDelete. 
    Tnew(toDelete, :) = [];
	
    %display, or print this table, which means it is displayed in the pdf.
   disp(Tnew)
end


