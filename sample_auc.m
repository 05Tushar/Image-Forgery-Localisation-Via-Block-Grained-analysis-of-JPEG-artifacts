filename_A = 'double_comp_nadjpg\forged_9_60_75.jpg';
% set parameters
c2=6;

im = jpeg_read(filename_A);

[LLRmap, LLRmap_s, q1table, k1e, k2e, alphat] = getJmapNA_EM(im, 1, c2);
standard_map=smooth_unshift(sum(LLRmap,3),k1e,k2e);
simplified_map=smooth_unshift(sum(LLRmap_s,3),k1e,k2e);

score_v=standard_map(:);
truth=ones(128);
truth(33:64,33:64)=0;
truth_v=truth(:);
[x,y,t,auc]=perfcurve(truth_v,score_v,1);
