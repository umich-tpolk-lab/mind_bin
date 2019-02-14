function addgaba2( subj, mainfile, currfile )
%addgaba Adds gaba stats from currfile to mainfile

load(currfile); % Load the gaba stats from the current subj

if exist(mainfile, 'file') % If we've already saved some subjs then augment the file
    load(mainfile);
    
    % Now look to see if the current subj is already in mainfile
    idx = 0;
    for i = 1:size(allstats.GABAuncorrected)
        if subj == allstats.subject(i,:)
            idx = i;
        end
    end
    if idx  % If this subj has been saved before then remove the previous data
       allstats.GABAuncorrected(idx) = [];
       allstats.GABACSFCorrected(idx) = [];
       allstats.GABATissCorrected(idx) = [];
       allstats.GABAAlphaTissCorrected(idx) = [];
       allstats.GABAAlphaTissCorrectedGrpNorm(idx) = [];
       allstats.GABACr(idx) = [];
       allstats.Glxuncorrected(idx) = [];
       allstats.GlxCSFCorrected(idx) = [];
       allstats.GlxTissCorrected(idx) = [];
       allstats.GlxAlphaTissCorrected(idx) = [];
       allstats.GlxAlphaTissCorrectedGrpNorm(idx) = [];
       allstats.GlxCr(idx) = [];
       allstats.WMfraction(idx) = [];
       allstats.GMfraction(idx) = [];
       allstats.CSFfraction(idx) = [];
       allstats.subject(idx,:) = [];
	   allstats.GABAArea(idx) = [];
	   allstats.GlxArea(idx) = [];
	   allstats.GABAFitErW(idx) =[];
	   allstats.GABAFitErCr(idx) = [];
	   allstats.GlxFitErW(idx) = [];
	   allstats.GlxFitErCr(idx) = [];
	   allstats.Reject(idx) = [];
    end
    
    % Now add the data from the current subj
    allstats.GABAuncorrected = [allstats.GABAuncorrected ; MRS.out.vox1.GABA.ConcIU];
    allstats.GABACSFCorrected = [allstats.GABACSFCorrected ; MRS.out.vox1.GABA.ConcIU_CSFcorr];
    allstats.GABATissCorrected = [allstats.GABATissCorrected; MRS.out.vox1.GABA.ConcIU_TissCorr];
    allstats.GABAAlphaTissCorrected = [allstats.GABAAlphaTissCorrected; MRS.out.vox1.GABA.ConcIU_AlphaTissCorr];
    allstats.GABAAlphaTissCorrectedGrpNorm = [allstats.GABAAlphaTissCorrectedGrpNorm; MRS.out.vox1.GABA.ConcIU_AlphaTissCorr_GrpNorm];
    allstats.GABACr = [allstats.GABACr; MRS.out.vox1.GABA.ConcCr];
    allstats.Glxuncorrected = [allstats.Glxuncorrected ; MRS.out.vox1.Glx.ConcIU];
    allstats.GlxCSFCorrected = [allstats.GlxCSFCorrected ; MRS.out.vox1.Glx.ConcIU_CSFcorr];
    allstats.GlxTissCorrected = [allstats.GlxTissCorrected; MRS.out.vox1.Glx.ConcIU_TissCorr];
    allstats.GlxAlphaTissCorrected = [allstats.GlxAlphaTissCorrected; MRS.out.vox1.Glx.ConcIU_AlphaTissCorr];
    allstats.GlxAlphaTissCorrectedGrpNorm = [allstats.GlxAlphaTissCorrectedGrpNorm; MRS.out.vox1.Glx.ConcIU_AlphaTissCorr_GrpNorm];
    allstats.GlxCr = [allstats.GlxCr ; MRS.out.vox1.Glx.ConcCr];
    allstats.WMfraction = [allstats.WMfraction; MRS.out.vox1.tissue.WMfra];
    allstats.GMfraction = [allstats.GMfraction; MRS.out.vox1.tissue.GMfra];
    allstats.CSFfraction = [allstats.CSFfraction; MRS.out.vox1.tissue.CSFfra];
    allstats.subject = [allstats.subject ; subj];
	allstats.GABAArea = [allstats.GABAArea ; MRS.out.vox1.GABA.Area];
	allstats.GlxArea = [allstats.GlxArea ; MRS.out.vox1.Glx.Area];
	allstats.GABAFitErW =[allstats.GABAFitErW ; MRS.out.vox1.GABA.FitError_W];
	allstats.GABAFitErCr = [allstats.GABAFitErCr ; MRS.out.vox1.GABA.FitError_Cr];
	allstats.GlxFitErW = [allstats.GlxFitErW ; MRS.out.vox1.Glx.FitError_W];
	allstats.GlxFitErCr = [allstats.GlxFitErCr ; MRS.out.vox1.Glx.FitError_Cr];
	Rejects = MRS.out.reject;
	reject_count = sum(Rejects);
	allstats.Reject = [allstats.Reject ; reject_count];

else  % Haven't saved any data before so start from scratch
    allstats.GABAuncorrected = MRS.out.vox1.GABA.ConcIU;
    allstats.GABACSFCorrected = MRS.out.vox1.GABA.ConcIU_CSFcorr;
    allstats.GABATissCorrected = MRS.out.vox1.GABA.ConcIU_TissCorr;
    allstats.GABAAlphaTissCorrected = MRS.out.vox1.GABA.ConcIU_AlphaTissCorr;
    allstats.GABAAlphaTissCorrectedGrpNorm = MRS.out.vox1.GABA.ConcIU_AlphaTissCorr_GrpNorm;
    allstats.GABACr = MRS.out.vox1.GABA.ConcCr;
    allstats.Glxuncorrected = MRS.out.vox1.Glx.ConcIU;
    allstats.GlxCSFCorrected = MRS.out.vox1.Glx.ConcIU_CSFcorr;
    allstats.GlxTissCorrected = MRS.out.vox1.Glx.ConcIU_TissCorr;
    allstats.GlxAlphaTissCorrected = MRS.out.vox1.Glx.ConcIU_AlphaTissCorr;
    allstats.GlxAlphaTissCorrectedGrpNorm = MRS.out.vox1.Glx.ConcIU_AlphaTissCorr_GrpNorm;
    allstats.GlxCr = MRS.out.vox1.Glx.ConcCr;    
    allstats.WMfraction = MRS.out.vox1.tissue.WMfra;
    allstats.GMfraction = MRS.out.vox1.tissue.GMfra;
    allstats.CSFfraction = MRS.out.vox1.tissue.CSFfra;
    allstats.subject = subj;
	allstats.GABAArea = MRS.out.vox1.GABA.Area;
	allstats.GlxArea = MRS.out.vox1.Glx.Area;
	allstats.GABAFitErW = MRS.out.vox1.GABA.FitError_W;
	allstats.GABAFitErCr = MRS.out.vox1.GABA.FitError_Cr;
	allstats.GlxFitErW = MRS.out.vox1.Glx.FitError_W;
	allstats.GlxFitErCr = MRS.out.vox1.Glx.FitError_Cr;
	Rejects = MRS.out.reject;
	reject_count = sum(Rejects);
	allstats.Reject = reject_count;

end

save(mainfile,'allstats');

end

