truth=ones(128);
truth(65:128,:)=0;
truth_v=truth(:);
QF1=[50 55 60 65 70 75 80 85 90 95];
QF2=[50 55 60 65 70 75 80 85 90 95 100];

auc_array=zeros(100,10,11,2);

for i=1:100
    source="double_comp_noise_nadjpg_half\forged_"+i+"_";
    for j=1:10
        source_im=source+QF1(j)+"_";
        for k=1:11
            source_img=source_im+QF2(k)+".jpg";
            c2=6;
            source_file_name = char(source_img);
            im = jpeg_read(source_file_name);
            [LLRmap, LLRmap_s, q1table, k1e, k2e, alphat] = getJmapNA_EM(im, 1, c2);
            standard_map=smooth_unshift(sum(LLRmap,3),k1e,k2e);
            simplified_map=smooth_unshift(sum(LLRmap_s,3),k1e,k2e);
            
            standard_map_v=standard_map(:);
            simplified_map_v=simplified_map(:);
            [x,y,t,auc]=perfcurve(truth_v, standard_map_v,1);
            [x1,y1,t1,auc1]=perfcurve(truth_v,simplified_map_v,1);
            auc_array(i,j,k,1)=auc;
            auc_array(i,j,k,2)=auc1;
            
        end
    end
end

save('auc_nadjpg_noise_half.mat','auc_array');