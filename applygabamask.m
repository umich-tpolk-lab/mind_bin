function applygabamask(twelvebetafile,gabaverticesfile,distinctfile)

%Apply binary mask you have once for lh and once for rh
% You will need to run this separately -- once for lh and once for rh

%mask beta with 12 regressors each for a block
temp = load_nifti(twelvebetafile);
beta = temp.vol;
num_regressors = size(beta,4)-3;

cond1orig = beta(1:end,1,1,1:(num_regressors/2));
cond2orig = beta(1:end,1,1,(num_regressors/2)+1:num_regressors);

cond1orig = squeeze(cond1orig); %removes the two extra dimensions that these files have
cond2orig = squeeze(cond2orig);

gbv = load_nifti(gabaverticesfile); % This is binary mask in the fsaverage surface space
gbv = gbv.vol;
newgbv = find(gbv~=0);
cond1 = cond1orig(newgbv,:);
cond2 = cond2orig(newgbv,:);
cond = [cond1 cond2];

corrmatrix = corrcoef(cond,'rows','pairwise');
cond1 = [1 1 1 1 1 1 0 0 0 0 0 0];
cond1 = logical(cond1);
cond2 = ~cond1;

within1 = corrmatrix(cond1,cond1);

within2 = corrmatrix(cond2,cond2);

between = corrmatrix(cond1,cond2);

sumwithin1 = sum(within1);
sumwithin2 = sum(within2);

avgwithin = (sum(sumwithin1) + sum(sumwithin2) - 12)/(60);
avgbetween = sum(sum(between))/(36);

distinctive = avgwithin - avgbetween;

save(distinctfile,'cond','avgwithin','avgbetween','distinctive','within1','within2','between');

end
