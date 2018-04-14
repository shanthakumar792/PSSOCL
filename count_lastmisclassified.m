clc;
clear all;
close all;
d1 = './alexnet-top1';
d2 = './googlenet-top1';
d3 = './nin-top1';
d4 = './vgg-top1';
di1 = dir(d1);
di2 = dir(d2);
di3 = dir(d3);
di4 = dir(d4);
num_cat = length(di1);
cla = 0;
c1=0;
c2=0;
c3=0;
c4=0;
for i=3:num_cat
    cat = di1(i).name;
    cat
    u=sprintf('./alexnet-top1/%s',cat);
    dik = dir(u);
    u4=sprintf('partnames1/%s.txt',cat);
    fid1=fopen(u4,'r');
    partn=textscan(fid1,'%s','delimiter','\n');
    k11=length(partn{1,1})+2;
    num_scheme=length(dik);
    for j=3:num_scheme
        scheme=dik(j).name;
        u1=sprintf('./alexnet-top1/%s/%s',cat,scheme);
        dik1=dir(u1);
        num_context=length(dik1);
        for k=3:num_context
            context=dik1(k).name;
            u12=sprintf('alexnet-top1/%s/%s/%s',cat,scheme,context);
            u22=sprintf('googlenet-top1/%s/%s/%s',cat,scheme,context);
            u32=sprintf('nin-top1/%s/%s/%s',cat,scheme,context);
            u42=sprintf('vgg-top1/%s/%s/%s',cat,scheme,context);
            fid1=fopen(u12,'r');
            result1=textscan(fid1,'%s %s','delimiter',',');
            fclose(fid1);
            fid1=fopen(u22,'r');
            result2=textscan(fid1,'%s %s','delimiter',',');
            fclose(fid1);
            fid1=fopen(u32,'r');
            result3=textscan(fid1,'%s %s','delimiter',',');
            fclose(fid1);
            fid1=fopen(u42,'r');
            result4=textscan(fid1,'%s %s','delimiter',',');
            fclose(fid1);
            pk1 = result1{1,1};
            pj1 = result1{1,2};
            pk2 = result2{1,1};
            pj2 = result2{1,2};
            pk3 = result3{1,1};
            pj3 = result3{1,2};
            pk4 = result4{1,1};
            pj4 = result4{1,2};
            lk(1)=length(pj1);
            lk(2)=length(pj2);
            lk(3)=length(pj3);
            lk(4)=length(pj4);
            lkk=min(lk);
            for v1=1:k11:lkk
                start = v1;
                r1=[];
                r2=[];
                r3=[];
                r4=[];
                cla = cla+1;
                for v2=start:start+k11-1
                    %v2
                    r1(v2-start+1)=pj1{v2,1}-48;
                    r2(v2-start+1)=pj2{v2,1}-48;
                    r3(v2-start+1)=pj3{v2,1}-48;
                    r4(v2-start+1)=pj4{v2,1}-48;
                end
                i1 = 0;
                for v2=1:k11-1
                    if(r1(v2)==1)
                        i1=1;
                    end
                end
                if(r1(k11)==0 && i1==1)
                    c1=c1+1;
                end
                i2 = 0;
                for v2=1:k11-1
                    if(r2(v2)==1)
                        i2=1;
                    end
                end
                if(r2(k11)==0 && i2==1)
                    c2=c2+1;
                end
                i3 = 0;
                for v2=1:k11-1
                    if(r3(v2)==1)
                        i3=1;
                    end
                end
                if(r3(k11)==0 && i3==1)
                    c3=c3+1;
                end
                i4 = 0;
                for v2=1:k11-1
                    if(r4(v2)==1)
                        i4=1;
                    end
                end
                if(r4(k11)==0 && i4==1)
                    c4=c4+1;
                end                
            end
        end
    end
end
la1 = c1/cla;
la2 = c2/cla;
la3 = c3/cla;
la4 = c4/cla;