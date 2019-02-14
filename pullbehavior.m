cd /nfs/tpolk/mind/data/mastersheet
master = readtable('mindmaster_clean.csv');
master = table2struct(master);
for i=1:size(master,1)
    if strcmp(master(i).EnrollmentStatus,'Completed')
        subject = master(i).Subject;
        WIN_Lcollect.(sprintf(subject)) = master(i).NIH_WIN_LeftRaw;
        WIN_Rcollect.(sprintf(subject)) = master(i).NIH_WIN_RightRaw;
        Fluidcollect.(sprintf(subject)) = master(i).NIH_Flu_USS;
        Crystalcollect.(sprintf(subject)) = master(i).NIH_Cry_USS;
        VAcollect.(sprintf(subject)) = master(i).NIH_VA_USS;
    end
end
savename = '/home/poortata/Desktop/MIND/behavior.mat';
save(savename,'VAcollect','Crystalcollect','Fluidcollect','WIN_Rcollect','WIN_Lcollect');
