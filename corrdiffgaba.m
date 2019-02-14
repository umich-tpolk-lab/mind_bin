function distinctive = corrdiffgaba(betasfile,distinctfile)
% Computes the difference between the avg within-group and between-group
% correlations in the matrix data.
%   data: Matrix in which rows are blocks & columns are voxels
%   groups: Vector indicating which rows are condition 1
%   cond1: Vector indicating which rows are condition 1
%   cond2:Vector indicating which rows are condition 2
%   exclude: Square matrix indicating which block-pairs to exclude


data = betasfile;

corrmatrix = corrcoef(data,'rows','pairwise');
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

save(distinctfile,'avgwithin','avgbetween','distinctive','within1','within2','between');

end