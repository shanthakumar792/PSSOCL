% for category based analysis of category epitomes.
function resultanalysis3_2
d='./nin';
di=dir(d);
num_cat=length(di)-2;
for i=3:num_cat+2
    cat=di(i).name;
    u1=sprintf('./nin/%s',cat);
    d1=dir(u1);
    q=1;
    num_scheme=length(d1);
    for j=3:num_scheme
        scheme=d1(j).name;
        if(~strcmp(scheme,'randomorder'))
        u2=sprintf('./ninfinal/%s/%s',cat,scheme);
        d2=dir(u2);
        num_context=length(d2);
        for k=3:num_context
            context=d2(k).name;
            u3=sprintf('ninfinal/%s/%s/%s',cat,scheme,context);
            load(u3);
            s1=h92;
            s2(q)=median(s1);
            q=q+1;
        end
        end
    end
    s3(i-2)=median(s2);
    s4(i-2)=std(s2)/sqrt(length(s2));
end
s3
end