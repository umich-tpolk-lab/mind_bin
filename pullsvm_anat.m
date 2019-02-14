cd('/nfs/tpolk/mind/freesurfer/func/')
list = dir;
for i=1:length(list)
    foldername = list(i).name;
    TF = strfind(foldername,'pmind');
    if TF
        cd('/nfs/tpolk/mind/freesurfer/func/')
        cd(foldername)
        ex = exist('auditory/left2009HGaud_distinct.mat','file');
        if ex>0
            cd('auditory')
            lhloaded = load('left2009HGaud_distinct.mat');
            rhloaded = load('right2009HGaud_distinct.mat');
            distinctcollect.(sprintf(foldername))=[lhloaded.distinctiveness rhloaded.distinctiveness];
        end
    end
end

savename = ['/home/poortata/Desktop/MIND/' 'auditory_anatsvm.mat']';
save(savename,'distinctcollect');
