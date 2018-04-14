clear all;
s=sprintf('./myoutput1/*');
d=dir(s);
v1=[];
for i=3:length(d)
    n=d(i).name;
    s1=sprintf('./myoutput1/%s/*.mat',n);
    s2=sprintf('./maskchange/%s/*.mat',n);
    d1=dir(s1);
    d2=dir(s2);
    for j=1:length(d1)
        n1=d1(j).name;
        p=0;
        imname=n1(1:11);
        year=n1(1:4);
        s5=sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s.jpg',year,year,imname);
        img=imread(s5);
        s4=sprintf('./myoutput1/%s/%s',n,n1);
        load(s4);
        for k=1:length(d2)
            if(strcmp(d2(k).name,n1) && p==0)
                p=1;
                s3=sprintf('./maskchange/%s/%s',n,d2(k).name);
                load(s3);
                v1.cat=s.cat;
                v1.mask=s.mask;
                v1.parts=s.parts;
                v1.index=s.index;
                v1.dim=dimension;
            end
        end
        if(p==0)
            v1.cat=s.cat;
            v1.mask=s.mask;
            v1.parts=s.parts;
            v1.index=s.index;
            v1.dim=[];
        end
        s6=sprintf('newfinal/%s/%s',n,n1(1:(length(n1)-4)));
        save(s6,'v1','-v7.3');
        v1=[];
    end
end