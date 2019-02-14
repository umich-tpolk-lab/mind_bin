function applystrucmask(betafile,verticesfile,maskedbetasfile)

%Apply a structural mask you have
% You will need to run this separately -- once for lh and once for rh

%mask_blocked
temp = load_nifti(betafile);
beta = temp.vol;
num_regressors = size(beta,4)-3;

cond1orig = beta(1:end,1,1,1:(num_regressors/2));
cond2orig = beta(1:end,1,1,(num_regressors/2)+1:num_regressors);

cond1orig = squeeze(cond1orig); %removes the two extra dimensions that these files have
cond2orig = squeeze(cond2orig);

load(verticesfile); % This is a mat file created using the .aparc file-it contains a single variable (idx) containing the matlab indices
% corresponding to the vertices in the structural mask of interest
cond1 = cond1orig(idx,:);
cond2 = cond2orig(idx,:);

save(maskedbetasfile,'cond1','cond2');% this is the file which goes as input to applyfuncmask.m 

end
