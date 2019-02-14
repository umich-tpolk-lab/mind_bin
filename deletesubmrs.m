

function deletesub(subj, voxel)

cd /nfs/tpolk/mind/mrs
load(voxel);

x = cellstr(allstats.subject);
y = string(x);
a = find(y == subj);

allstats.GABAuncorrected(a, :) = [];
allstats.GABACSFCorrected(a, :) = [];
allstats.GABATissCorrected(a, :) = [];
allstats.GABAAlphaTissCorrected(a, :) = [];
allstats.GABAAlphaTissCorrectedGrpNorm(a, :) = [];
allstats.GABACr(a, :) = [];
allstats.Glxuncorrected(a, :) = [];
allstats.GlxCSFCorrected(a, :) = [];
allstats.GlxTissCorrected(a, :) = [];
allstats.GlxAlphaTissCorrected(a, :) = [];
allstats.GlxAlphaTissCorrectedGrpNorm(a, :) = [];
allstats.GlxCr(a, :) = [];
allstats.GMfraction(a, :) = [];
allstats.WMfraction(a, :) = [];
allstats.CSFfraction(a, :) = [];
allstats.subject(a, :) = [];

save(voxel);


end 