load('auc_nadjpg_smooth_half.mat');
avg_auc_standard=zeros(10,11);
avg_auc_simplified=zeros(10,11);

for j=1:10
    for k=1:11
        temp1=sum(auc_array(:,j,k,1));
        temp2=sum(auc_array(:,j,k,2));
        avg_auc_standard(j,k)=temp1/100;
        avg_auc_simplified(j,k)=temp2/100;
    end
end
save('avg_auc_nadjpg_smooth_half_stand.mat','avg_auc_standard');
save('avg_auc_nadjpg_smooth_half_simp.mat','avg_auc_simplified');