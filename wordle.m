function wordle
classifier='googlenet-top1';
s=sprintf('./partimportance1/%s',classifier);
d=dir(s);
num_cat=length(d);
s6=sprintf('./partimportance3/%s',classifier);
for i=3:num_cat
    cat=d(i).name;
    mkdir(s6,cat);
    s1=sprintf('./partimportance1/%s/%s',classifier,cat);
    d1=dir(s1);
    num_things=length(d1);
    s3=sprintf('./partnames1/%s.txt',cat);
    fid=fopen(s3,'r');
    part=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    parts=part{1,1};
    s5=sprintf('./partimportance3/%s/%s',classifier,cat);
    for j=3:num_things
        thing=d1(j).name;
        s2=sprintf('./partimportance1/%s/%s/%s',classifier,cat,thing);
        fid=fopen(s2,'r');
        weights=textscan(fid,'%f','delimiter','\n');
        fclose(fid);
        h=0;
        p=weights{1,1};
        psum=sum(p);
        for k=1:length(p)
            p(k)=p(k)/psum;
            p(k)=round(p(k)*100);
        end
        s4=sprintf('./partimportance3/%s/%s/%s.txt',classifier,cat,thing(1:(length(thing)-4)));
        fid=fopen(s4,'w');
        for k=1:length(p)
           times=p(k);
           toinsert=parts{k,1};
           for m=1:times
               fprintf(fid,'%s\r\n',toinsert);
           end
        end
       fclose(fid);
    end
    
end
end