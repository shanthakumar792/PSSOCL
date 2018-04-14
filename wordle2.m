function wordle2
s=sprintf('./partimportance4/*.txt');
d=dir(s);
num_cat=length(d);
for i=1:num_cat
    cat=d(i).name;
    s1=sprintf('./partimportance6/%s',cat);
    fid=fopen(s1,'r');
    w=textscan(fid,'%f','delimiter','\n');
    weights=w{1,1};
    fclose(fid);
    s3=sprintf('./partnames1/%s',cat);
    fid=fopen(s3,'r');
    part=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    parts=part{1,1};
    psum=sum(weights);
    e=0;
    for k=1:length(weights)
       weights(k)=weights(k)/psum;
       weights(k)=round(weights(k)*100);
    end
    s4=sprintf('./partimportance7/%s',cat);
    fid=fopen(s4,'w');
    for k=1:length(weights)
           times=weights(k);
           toinsert=parts{k,1};
           for m=1:times
               fprintf(fid,'%s\r\n',toinsert);
           end
    end
    psum=sum(weights);
    for k=1:length(weights)
        weights(k)=weights(k)/psum;
        if(weights(k)~=0)
            e=e-(weights(k)*log2(weights(k)));
        end
    end
    e
    fclose(fid);
end
end