% for category based analysis of category epitomes.
function resultanalysis3
d='./alexnet';
di=dir(d);
num_cat=length(di)-2;
for i=3:num_cat+2
    cat=di(i).name;
    u1=sprintf('./alexnet/%s',cat);
    d11=dir(u1);
    q=1;
    num_scheme=length(d11);
    min_epitome_score=zeros(1,4);
    max_epitome_score=zeros(1,4);
    for j=3:num_scheme
        scheme=d11(j).name;
        if(~strcmp(scheme,'randomorder'))
        u2=sprintf('./alexnetfinal/%s/%s',cat,scheme);
        d2=dir(u2);
        num_context=length(d2);
        for k=3:num_context
            context=d2(k).name;
            u3=sprintf('alexnetfinal/%s/%s/%s',cat,scheme,context);
            u4=sprintf('googlenetfinal/%s/%s/%s',cat,scheme,context);
            u5=sprintf('ninfinal/%s/%s/%s',cat,scheme,context);
            u6=sprintf('vgg-19final/%s/%s/%s',cat,scheme,context);
            load(u3);
            load(u4);
            load(u5);
            load(u6);
            s1=h90;
            s2=h91;
            s3=h92;
            s4=h93;
            s22(1)=median(s1);
            s22(2)=median(s2);
            s22(3)=median(s3);
            s22(4)=median(s4);
            [minpos]=min(s22(1:4));
            [maxpos]=max(s22);
            for kl=1:4
                if(minpos==s22(kl))
                    min_epitome_score(kl)=min_epitome_score(kl)+1;
                end
                if(maxpos==s22(kl))
                    max_epitome_score(kl)=max_epitome_score(kl)+1;
                end
            end
            q=q+1;
        end
        end
    end
[~,s33(i-2)]=max(min_epitome_score);
[~,s44(i-2)]=max(max_epitome_score);
end
end