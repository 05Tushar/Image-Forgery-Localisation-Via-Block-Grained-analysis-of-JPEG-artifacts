truth=ones(128);
truth(33:64,33:64)=0;
truth_v=truth(:);
QF1=[50 55 60 65 70 75 80 85 90 95];
QF2=[50 55 60 65 70 75 80 85 90 95 100];

auc_array=zeros(100,10,11,2);

for i=1:100
    source="double_comp_noise\forged_"+i+"_";
    for j=1:10
        source_im=source+QF1(j)+"_";
        for k=1:11
            source_img=source_im+QF2(k)+".jpg";
            c2=6;
            source_file_name = char(source_img);
            im = jpeg_read(source_file_name);
            [LLRmap, LLRmap_s, q1table, alphat] = getJmap_EM(im, 1, c2);
            %standard_map=sum(LLRmap,3);
            standard_map = imfilter(sum(LLRmap,3), ones(3), 'symmetric', 'same');
            simplified_map = imfilter(sum(LLRmap_s,3), ones(3), 'symmetric', 'same');
            %simplified_map=sum(LLRmap_s,3);
            standard_map_v=standard_map(:);
            simplified_map_v=simplified_map(:);
            [x,y,t,auc]=perfcurve(truth_v, standard_map_v,1);
            [x1,y1,t1,auc1]=perfcurve(truth_v,simplified_map_v,1);
            auc_array(i,j,k,1)=auc;
            auc_array(i,j,k,2)=auc1;
            
        end
    end
end

save('auc_adjpg_noise.mat','auc_array');