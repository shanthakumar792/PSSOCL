function resultanalysis7
classifier='googlenet-top1';
s=sprintf('./partimportance/%s',classifier);
d=dir(s);
num_cat=length(d);
for i=3:num_cat
    cat=d(i).name;
    s1=sprintf('./partimportance/%s/%s',classifier,cat);
    d1=dir(s1);
    num_scheme=length(d1);
    scheme=d1(3).name;
    s2=sprintf('./partimportance/%s/%s/%s',classifier,cat,scheme);
        fid=fopen(s2,'r');
        part=textscan(fid,'%s','delimiter','\n');
        fclose(fid);
        p1=zeros(length(part{1,1}),1);
    for j=3:num_scheme
        scheme=d1(j).name;
        s2=sprintf('./partimportance/%s/%s/%s',classifier,cat,scheme);
        fid=fopen(s2,'r');
        part=textscan(fid,'%d','delimiter','\n');
        fclose(fid);
        p=part{1,1};
        for k=1:length(p)
            p1(k)=p1(k)+p(k);
        end
    end
    s4=sprintf('./partimportance1/%s',classifier);
    mkdir(s4,cat);
    s3=sprintf('./partimportance1/%s/%s/over-all.txt',classifier,cat);
    fid=fopen(s3,'w');
    fprintf(fid,'%f\r\n',p1);
    fclose(fid);
end
end