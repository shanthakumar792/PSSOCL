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
u4 = sprintf('imagenet_pascal_res_sim_scores.txt');
fid1 = fopen(u4,'r');
result9=textscan(fid1,'%s %s %s %s %s','delimiter',',');
fclose(fid1);
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
    m11=sprintf('alexnetfinal2/%s',cat);
    m21=sprintf('googlenetfinal2/%s',cat);
    m31=sprintf('ninfinal2/%s',cat);
    m41=sprintf('vgg-19final2/%s',cat);
    m13=sprintf('alexnetfinal3/%s',cat);
    m23=sprintf('googlenetfinal3/%s',cat);
    m33=sprintf('ninfinal3/%s',cat);
    m43=sprintf('vgg-19final3/%s',cat);
    for j=3:num_scheme
        scheme=dik(j).name;
        mkdir(m11,scheme);
        mkdir(m21,scheme);
        mkdir(m31,scheme);
        mkdir(m41,scheme);
        mkdir(m13,scheme);
        mkdir(m23,scheme);
        mkdir(m33,scheme);
        mkdir(m43,scheme);
        u1=sprintf('./alexnet-top1/%s/%s',cat,scheme);
        dik1=dir(u1);
        num_context=length(dik1);
        for k=3:num_context
            context=dik1(k).name;
            m12=sprintf('alexnetfinal2/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            m14=sprintf('alexnetfinal3/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            u12=sprintf('alexnet-top1/%s/%s/%s',cat,scheme,context);
            m22=sprintf('googlenetfinal2/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            m24=sprintf('googlenetfinal3/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            u22=sprintf('googlenet-top1/%s/%s/%s',cat,scheme,context);
            m32=sprintf('ninfinal2/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            m34=sprintf('ninfinal3/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            u32=sprintf('nin-top1/%s/%s/%s',cat,scheme,context);
            m42=sprintf('vgg-19final2/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            m44=sprintf('vgg-19final3/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4)); 
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
            l1 = 0;
            l2 = 0;
            l3 = 0;
            l4 = 0;
            h90=[];
            h91=[];
            h92=[];
            h93=[];
            j90=[];
            j91=[];
            j92=[];
            j93=[];
            for v1=1:k11:lkk
                start = v1;
                r1=[];
                r2=[];
                r3=[];
                r4=[];
                for v2=start:start+k11-1
                    %v2
                    r1(v2-start+1)=str2num(pk1{v2,1});
                    r2(v2-start+1)=str2num(pk2{v2,1});
                    r3(v2-start+1)=str2num(pk3{v2,1});
                    r4(v2-start+1)=str2num(pk4{v2,1});
                end
                s1=0;
                s=0;
                p11 = 0;
                for v2 =1:k11
                    p11 = p11+ ((k11-v2+1)/k11);
                end
                for v2 =1:k11
                    %v2
                    s1 = s1 + ((k11-v2+1)/p11)*semantic_cal(cat,r1(v2),result9);
                end
                s1 = s1/k11;
                s = 1 - s1;
                l1 = l1+1;
                h90(l1)= s;
                j90(l1)=r1(k11);
                s1=0;
                s=0;
                for v2 =1:k11
                    %v2
                    s1 = s1 + ((k11-v2+1)/p11)*semantic_cal(cat,r2(v2),result9);
                end
                s1 = s1/k11;
                s = 1 - s1;
                l2 = l2+1;
                h91(l2)= s;
                j91(l2)=r2(k11);
                s1=0;
                s=0;
                for v2 =1:k11
                    %v2
                    s1 = s1 + ((k11-v2+1)/p11)*semantic_cal(cat,r3(v2),result9);
                end
                s1 = s1/k11;
                s = 1 - s1;
                l3 = l3+1;
                h92(l3)= s;
                j92(l3)=r3(k11);
                s1=0;
                s=0;
                for v2 =1:k11
                    %v2
                    s1 = s1 + ((k11-v2+1)/p11)*semantic_cal(cat,r4(v2),result9);
                end
                s1 = s1/k11;
                s = 1 - s1;
                l4 = l4+1;
                h93(l4)= s;
                j93(l4)=r4(k11);
            end
            save(m12,'h90','-v7.3');
            save(m22,'h91','-v7.3');
            save(m32,'h92','-v7.3');
            save(m42,'h93','-v7.3');
        end
    end
        
end
