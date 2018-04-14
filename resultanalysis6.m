function resultanalysis6(classifier,category,context)
s8=sprintf('./partimportance/%s',classifier);
mkdir(s8,category)
pp=sprintf('./partnames1/%s.txt',category);
fid=fopen(pp,'r');
partn=textscan(fid,'%s','delimiter','\n');
fclose(fid);
num_parts=length(partn{1,1});
parts=partn{1,1};
factor=num_parts+2;
p=zeros(num_parts,1);
s=sprintf('./shantha_result_2/%s/resultsfinal/%s',classifier,category);
d=dir(s);
num_scheme=length(d);
for i=3:num_scheme
    scheme=d(i).name;
    if(~strcmp(scheme,'randomorder') && ~strcmp(scheme,'temporal') && ~strcmp(scheme,'alternate'))
    s1=sprintf('./shantha_result_2/%s/resultsfinal/%s/%s/%s.mat',classifier,category,scheme,context);
    s2=sprintf('./order1/%s/%s.txt',category,scheme);
    fid1=fopen(s2,'r');
    order=textscan(fid1,'%s','delimiter','\n');
    fclose(fid1);
    order_p=order{1,1};
    load(s1);
    n=length(h91);
    for j=1:n
        f=(round(h91(j)*factor)-1);
        lk1=1;
        if(f>=length(order_p))
            f=length(order_p);
        end
        if(f<1)
            f=1;
            lk1=0;
        end
        if(lk1==1)
        for k=1:f
            partthere=order_p{k,1};
            for h=1:num_parts
                if(strcmp(partthere,parts{h,1}))
                    p(h)=p(h)+1;
                end
            end
        end
        end
    end
    end
end
s4=sprintf('./partimportance/%s/%s/%s.txt',classifier,category,context);
fid2=fopen(s4,'w');
fprintf(fid2,'%d\r\n',p);
end