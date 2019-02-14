function pullgabadistinct(taskname)

cd /nfs/tpolk/mind/freesurfer/func
flist = dir;
flist = {flist.name};
include = ~cellfun('isempty',strfind(flist,'pmind'));
subjectlist = flist(include);
subjectlist = char(subjectlist);

taskname = taskname;% 'auditory' 'visual' 'motor' 'tactile'

if strcmp(taskname,'auditory') == 1
    excludelist = ['pmindo100';'pmindy101';'pmindo107';'pmindo149'];
    si = size(excludelist);
    for e=1:si(1)
        exclude = excludelist(e,:);
        exc = find(ismember(subjectlist,exclude,'rows'));
        subjectlist(exc,:)=[];
    end

    for s=1:length(subjectlist)
        subject = subjectlist(s,1:9);  
        distinctlist = nan(1,2);
        withinlist = nan(1,2); 
        betweenlist = nan(1,2);
        betaslh = [];
        betasrh = [];
        hemi = ['lh';'rh'];
        for i = 1:2
            fname = ['/nfs/tpolk/mind/freesurfer/func/' subject '/auditory/musicspeech.sm5.12blks.' hemi(i,:) '/distinct_gaba' hemi(i,:) '.mat'];
            data = load(fname);
            distinctlist(i) = data.distinctive;
            withinlist(i) = data.avgwithin;
            betweenlist(i) = data.avgbetween;
            if i == 1
                betaslh = data.cond';
            elseif i == 2
                betasrh = data.cond';
            end
        end
        distcollect.(sprintf(subject))=distinctlist;
        withincollect.(sprintf(subject))=withinlist;
        betweencollect.(sprintf(subject))=betweenlist;
        
        betas = [betaslh,betasrh]';
        bothhemdistinctive = corrdiffgaba(betas,'bothhemdistinctive_gaba');
        distwholegabacollect.(sprintf(subject))=bothhemdistinctive;
    end
    savename = ['/nfs/tpolk/mind/freesurfer/func/RESULTS/MRSVoxelsDistinct/auditory'];
    save([savename '_gabadist.mat']','distcollect');
    save([savename '_gabawithin.mat']','withincollect');
    save([savename '_gababetween.mat']','betweencollect');
    save([savename '_gabawholedist.mat']','distwholegabacollect');

    %create csv combining dist,within,and between
    myfieldnames = fieldnames(distcollect);
    s = size(myfieldnames,1);
    dist_lh = [];
    dist_rh = [];
    with_lh =[];
    with_rh = [];
    bt_lh = [];
    bt_rh = [];
    bothhem = [];

    for i = 1:s
        distvalues = getfield(distcollect,myfieldnames{i});
        withvalues = getfield(withincollect,myfieldnames{i});
        btvalues = getfield(betweencollect,myfieldnames{i});
        bothvalues = getfield(distwholegabacollect,myfieldnames{i});

        dist_lh = [dist_lh; distvalues(1)];
        dist_rh = [dist_rh; distvalues(2)];
        with_lh = [with_lh; withvalues(1)];
        with_rh = [with_rh; withvalues(2)];
        bt_lh = [bt_lh; btvalues(1)];
        bt_rh = [bt_rh; btvalues(2)];
        bothhem = [bothhem; bothvalues];
    end

    varnames = {'Sub','MRS_D_aud_lh','MRS_D_aud_rh','MRS_W_aud_lh','MRS_W_aud_rh','MRS_B_aud_lh','MRS_B_aud_rh','MRS_aud_both'};
    t = table(myfieldnames,dist_lh,dist_rh,with_lh,with_rh,bt_lh,bt_rh,bothhem,...
        'VariableNames',varnames);


    writetable(t,[savename '_gabaall.csv']);
        
end

if strcmp(taskname,'visual') == 1
    excludelist = ['pmindo105';'pmindo114';'pmindo133';'pmindo149';'pmindy125'];
    si = size(excludelist);
    for e=1:si(1)
        exclude = excludelist(e,:);
        exc = find(ismember(subjectlist,exclude,'rows'));
        subjectlist(exc,:)=[];
    end

    for s=1:length(subjectlist)
        subject = subjectlist(s,1:9);  
        distinctlist = nan(1,2);
        withinlist = nan(1,2); 
        betweenlist = nan(1,2);
        betaslh = [];
        betasrh = [];
        hemi = ['lh';'rh'];
        for i = 1:2
            fname = ['/nfs/tpolk/mind/freesurfer/func/' subject '/visual/houseface.sm5.12blks.' hemi(i,:) '/distinct_gaba' hemi(i,:) '.mat'];
            data = load(fname);
            distinctlist(i) = data.distinctive;
            withinlist(i) = data.avgwithin;
            betweenlist(i) = data.avgbetween;
            if i == 1
                betaslh = data.cond';
            elseif i == 2
                betasrh = data.cond';
            end
        end
        
        distcollect.(sprintf(subject))=distinctlist;
        withincollect.(sprintf(subject))=withinlist;
        betweencollect.(sprintf(subject))=betweenlist;

        betas = [betaslh,betasrh]';
        bothhemdistinctive = corrdiffgaba(betas,'bothhemdistinctive_gaba');
        distwholegabacollect.(sprintf(subject))=bothhemdistinctive;
    end
    
    savename = ['/nfs/tpolk/mind/freesurfer/func/RESULTS/MRSVoxelsDistinct/visual'];
    save([savename '_gabadist.mat']','distcollect');
    save([savename '_gabawithin.mat']','withincollect');
    save([savename '_gababetween.mat']','betweencollect');
    save([savename '_gabawholedist.mat']','distwholegabacollect');

    %create csv combining dist,within,and between
    myfieldnames = fieldnames(distcollect);
    s = size(myfieldnames,1);
    dist_lh = [];
    dist_rh = [];
    with_lh =[];
    with_rh = [];
    bt_lh = [];
    bt_rh = [];
    bothhem = [];

    for i = 1:s
        distvalues = getfield(distcollect,myfieldnames{i});
        withvalues = getfield(withincollect,myfieldnames{i});
        btvalues = getfield(betweencollect,myfieldnames{i});
        bothvalues = getfield(distwholegabacollect,myfieldnames{i});

        dist_lh = [dist_lh; distvalues(1)];
        dist_rh = [dist_rh; distvalues(2)];
        with_lh = [with_lh; withvalues(1)];
        with_rh = [with_rh; withvalues(2)];
        bt_lh = [bt_lh; btvalues(1)];
        bt_rh = [bt_rh; btvalues(2)];
        bothhem = [bothhem; bothvalues];
    end

    varnames = {'Sub','MRS_D_vis_lh','MRS_D_vis_rh','MRS_W_vis_lh','MRS_W_vis_rh','MRS_B_vis_lh','MRS_B_vis_rh','MRS_vis_both'};
    t = table(myfieldnames,dist_lh,dist_rh,with_lh,with_rh,bt_lh,bt_rh,bothhem,...
        'VariableNames',varnames);

    writetable(t,[savename '_gabaall.csv']);
        
end


if strcmp(taskname,'motor') == 1
    excludelist = ['pmindo149'];
    si = size(excludelist);
    for e=1:si(1)
        exclude = excludelist(e,:);
        exc = find(ismember(subjectlist,exclude,'rows'));
        subjectlist(exc,:)=[];
    end

    for s=1:length(subjectlist)
        subject = subjectlist(s,1:9);  
        distinctlist = nan(1,2);
        withinlist = nan(1,2); 
        betweenlist = nan(1,2);
        betaslh = [];
        betasrh = [];
        hemi = ['lh';'rh'];
        
        for i = 1:2
            fname = ['/nfs/tpolk/mind/freesurfer/func/' subject '/motor/rightleftm.sm5.12blks.' hemi(i,:) '/distinct_gaba' hemi(i,:) '.mat'];
            data = load(fname);
            distinctlist(i) = data.distinctive;
            withinlist(i) = data.avgwithin;
            betweenlist(i) = data.avgbetween;
            if i == 1
                betaslh = data.cond';
            elseif i == 2
                betasrh = data.cond';
            end
        end
        
        distcollect.(sprintf(subject))=distinctlist;
        withincollect.(sprintf(subject))=withinlist;
        betweencollect.(sprintf(subject))=betweenlist;

        betas = [betaslh,betasrh]';
        bothhemdistinctive = corrdiffgaba(betas,'bothhemdistinctive_gaba');
        distwholegabacollect.(sprintf(subject))=bothhemdistinctive;
    end
    
    savename = ['/nfs/tpolk/mind/freesurfer/func/RESULTS/MRSVoxelsDistinct/motor'];
    save([savename '_gabadist.mat']','distcollect');
    save([savename '_gabawithin.mat']','withincollect');
    save([savename '_gababetween.mat']','betweencollect');
    save([savename '_gabawholedist.mat']','distwholegabacollect');

    %create csv combining dist,within,and between
    myfieldnames = fieldnames(distcollect);
    s = size(myfieldnames,1);
    dist_lh = [];
    dist_rh = [];
    with_lh =[];
    with_rh = [];
    bt_lh = [];
    bt_rh = [];
    bothhem = [];

    for i = 1:s
        distvalues = getfield(distcollect,myfieldnames{i});
        withvalues = getfield(withincollect,myfieldnames{i});
        btvalues = getfield(betweencollect,myfieldnames{i});
        bothvalues = getfield(distwholegabacollect,myfieldnames{i});

        dist_lh = [dist_lh; distvalues(1)];
        dist_rh = [dist_rh; distvalues(2)];
        with_lh = [with_lh; withvalues(1)];
        with_rh = [with_rh; withvalues(2)];
        bt_lh = [bt_lh; btvalues(1)];
        bt_rh = [bt_rh; btvalues(2)];
        bothhem = [bothhem; bothvalues];
    end

    varnames = {'Sub','MRS_D_mot_lh','MRS_D_mot_rh','MRS_W_mot_lh','MRS_W_mot_rh','MRS_B_mot_lh','MRS_B_mot_rh','MRS_mot_both'};
    t = table(myfieldnames,dist_lh,dist_rh,with_lh,with_rh,bt_lh,bt_rh,bothhem,...
        'VariableNames',varnames);

    writetable(t,[savename '_gabaall.csv']);
        
end


if strcmp(taskname,'tactile') == 1
    excludelist = ['pmindo140';'pmindo143';'pmindo149';'pmindo150'];
    si = size(excludelist);
    for e=1:si(1)
        exclude = excludelist(e,:);
        exc = find(ismember(subjectlist,exclude,'rows'));
        subjectlist(exc,:)=[];
    end

    for s=1:length(subjectlist)
        subject = subjectlist(s,1:9);  
        distinctlist = nan(1,2);
        withinlist = nan(1,2); 
        betweenlist = nan(1,2);
        betaslh = [];
        betasrh = [];
        hemi = ['lh';'rh'];

        for i = 1:2
            fname = ['/nfs/tpolk/mind/freesurfer/func/' subject '/tactile/rightleftt.sm5.12blks.' hemi(i,:) '/distinct_gaba' hemi(i,:) '.mat'];
            data = load(fname);
            distinctlist(i) = data.distinctive;
            withinlist(i) = data.avgwithin;
            betweenlist(i) = data.avgbetween;
            if i == 1
                betaslh = data.cond';
            elseif i == 2
                betasrh = data.cond';
            end
        end
        
        distcollect.(sprintf(subject))=distinctlist;
        withincollect.(sprintf(subject))=withinlist;
        betweencollect.(sprintf(subject))=betweenlist;

        betas = [betaslh,betasrh]';
        bothhemdistinctive = corrdiffgaba(betas,'bothhemdistinctive_gaba');
        distwholegabacollect.(sprintf(subject))=bothhemdistinctive;
    end
    
    savename = ['/nfs/tpolk/mind/freesurfer/func/RESULTS/MRSVoxelsDistinct/tactile'];
    save([savename '_gabadist.mat']','distcollect');
    save([savename '_gabawithin.mat']','withincollect');
    save([savename '_gababetween.mat']','betweencollect');
    save([savename '_gabawholedist.mat']','distwholegabacollect');

    %create csv combining dist,within,and between
    myfieldnames = fieldnames(distcollect);
    s = size(myfieldnames,1);
    dist_lh = [];
    dist_rh = [];
    with_lh =[];
    with_rh = [];
    bt_lh = [];
    bt_rh = [];
    bothhem = [];

    for i = 1:s
        distvalues = getfield(distcollect,myfieldnames{i});
        withvalues = getfield(withincollect,myfieldnames{i});
        btvalues = getfield(betweencollect,myfieldnames{i});
        bothvalues = getfield(distwholegabacollect,myfieldnames{i});

        dist_lh = [dist_lh; distvalues(1)];
        dist_rh = [dist_rh; distvalues(2)];
        with_lh = [with_lh; withvalues(1)];
        with_rh = [with_rh; withvalues(2)];
        bt_lh = [bt_lh; btvalues(1)];
        bt_rh = [bt_rh; btvalues(2)];
        bothhem = [bothhem; bothvalues];
    end

    varnames = {'Sub','MRS_D_tact_lh','MRS_D_tact_rh','MRS_W_tact_lh','MRS_W_tact_rh','MRS_B_tact_lh','MRS_B_tact_rh','MRS_tact_both'};
    t = table(myfieldnames,dist_lh,dist_rh,with_lh,with_rh,bt_lh,bt_rh,bothhem,...
        'VariableNames',varnames);

    writetable(t,[savename '_gabaall.csv']);
        
end

