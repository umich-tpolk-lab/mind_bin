function applyfuncmask(roisize,lh2condsfile,rh2condsfile,lh12condsfile,rh12condsfile,funcmaskfile)
% Create a functional mask and apply it

lh = load(lh2condsfile);
rh = load(rh2condsfile);
lh12 = load(lh12condsfile);
rh12 = load(rh12condsfile);

cond1 = vertcat(lh.cond1,rh.cond1);
cond2 = vertcat(lh.cond2,rh.cond2);

cond1twelve = vertcat(lh12.cond1,rh12.cond1);
cond2twelve = vertcat(lh12.cond2,rh12.cond2);


%disp(size(cond1));
%disp(size(cond2));

[beta_cond1,index_cond1] = sort(cond1(:),'descend'); % Sort data matrix d ('activation matrix') in descending order
[beta_cond2,index_cond2] = sort(cond2(:),'descend');

included_vertices = [];
i = 1; j= 1; % index i tracks cond1, index j tracks cond2
for k = 1:round(roisize/2)
    while (ismember(index_cond1(i),included_vertices))
        i = i+1;  
    end
    included_vertices(2*k-1) = index_cond1(i);
    i=i+1;
    
    while (ismember(index_cond2(j),included_vertices))
        j=j+1;
    end
    included_vertices(2*k) = index_cond2(j);
    j=j+1;
end 

cond1twelvemskd = cond1twelve(included_vertices,:);
cond2twelvemskd = cond2twelve(included_vertices,:);
betas = [cond1twelvemskd cond2twelvemskd];

save(funcmaskfile,'included_vertices', 'cond1twelve','cond2twelve','cond1twelvemskd', 'cond2twelvemskd','betas'); 
%this file can be given as input to corrdiff that will calculate distinctiveness. Contains 2 roisize*6 matrices

end
