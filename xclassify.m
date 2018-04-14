context{1}='length';
context{2}='randomorder';
context{3}='saliencytype1';
context{4}='saliencytype2';
context{5}='saliency_area_normalized_partseq_unweighted';
context{6}='saliency_area_normalized_partseq_weighted';
d='./shantha_result_2';
context1{1}='without_context.mat';
context1{2}='with_context.mat';
context1{3}='blurcontext1.mat';
context1{4}='blurcontext2.mat';
di=dir(d);
d2='./results1';
di2=dir(d2);
num_cat=length(di2)-2;
category='person';
global_counter=zeros(1,4);
for i=1:6
    for j=1:4
        lo=0;
        for k=3:length(di)
            n1=di(k).name;
            d1=sprintf('./shantha_result_2/%s/resultsfinal/%s/%s/%s',n1,category,context{i},context1{j});
            load(d1);
            s1=h90;
            s2(k-2)=median(s1);
        end
        [minimum,idx]=max(s2);
        for k1=1:length(di)-2
            if(k1~=idx)
                if(s2(k1)==minimum)
                    lo=1;
                end
            end
        end
        if(lo==0)
        global_counter(idx)=global_counter(idx)+1;
        end
    end
end
[mode_count,pos1]=max(global_counter);
pos1

