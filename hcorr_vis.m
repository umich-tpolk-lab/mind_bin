function hcorr_vis(roisize) %maskedrawfile

%Apply a structural mask you have

%mask_blocked
temp = load_nifti('visual/001/fmcpr.sm0.fsaverage.lh.nii.gz');
rawlh = temp.vol;
rawlh = squeeze(rawlh);
temp2 = load_nifti('visual/001/fmcpr.sm0.fsaverage.rh.nii.gz');
rawrh = temp2.vol;
rawrh = squeeze(rawrh);

lh = load('/nfs/tpolk/mind/freesurfer/func/visualverticeslh.mat'); 
rh = load('/nfs/tpolk/mind/freesurfer/func/visualverticesrh.mat'); 
rawlh = rawlh(lh.idx,:);
rawrh = rawrh(rh.idx,:);
raw = vertcat(rawlh,rawrh);
% this is the file which goes as input to applyfuncmask.m

%go to right directory
funcname = ['visual/funcmasked_sm_sm' num2str(roisize) '.mat'];
load(funcname);

raw = raw(included_vertices,:);
raw = raw';
%save(maskedrawfile,'raw');

corr = corrcoef(detrend(raw));

len = size(raw);
corrcoll = NaN(len(2));

for i=2:len(2)
for j=1:i-1
corrcoll(i,j) = corr(i,j);
end
end

savename = ['visual/hcorr_vis' num2str(roisize) '.mat'];
corrcoll(isnan(corrcoll)) = [];
hcorr = std(corrcoll)/sqrt(length(corrcoll));
save(savename,'hcorr');

end
