%% This is for analysis based on Part_schemes.
clc;
clear all;
close all;
d1 = './alexnetfinal';
di1 = dir(d1);
num_cat = length(di1);
catsam = di1(3).name;
d2 = sprintf('./alexnetfinal/%s',catsam);
di2 = dir(d2);
num_scheme=length(di2);
for j=3:num_scheme
    a{j-2}=di2(j).name;
end
for i=1:num_scheme-2
    scheme = a{i};
    c1=[];
    c2=[];
    c3=[];
    c4=[];
    d1=[];
    d2=[];
    d3=[];
    d4=[];
    for j=3:num_cat
        b=[];
        b1=[];
        b2=[];
        b3=[];
        cat = di1(j).name;
        u = sprintf('./alexnetfinal/%s/%s',cat,scheme);
        dik = dir(u);
        num_context=length(dik);
        for k=3:num_context
            context = dik(k).name;
            context = context(1:length(context)-4);
            u1=sprintf('./alexnetfinal2/%s/%s/%s.mat',cat,scheme,context);
            ak = load(u1);
            b =horzcat(b,ak.h90);
            u1=sprintf('./googlenetfinal2/%s/%s/%s.mat',cat,scheme,context);
            ak = load(u1);
            b1 =horzcat(b1,ak.h91); 
            u1=sprintf('./ninfinal2/%s/%s/%s.mat',cat,scheme,context);
            ak = load(u1);
            b2 =horzcat(b2,ak.h92);  
            u1=sprintf('./vgg-19final2/%s/%s/%s.mat',cat,scheme,context);
            ak = load(u1);
            b3 =horzcat(b3,ak.h93);
        end
        cas = median(b);
        das=mad(b,1);
        d1=horzcat(d1,das);
        c1=horzcat(c1,cas);
        cas =median(b1);
        das=mad(b1,1);
        d2=horzcat(d2,das);        
        c2=horzcat(c2,cas);
        cas = median(b2);
        das=mad(b2,1);
        d3=horzcat(d3,das);        
        c3=horzcat(c3,cas);
        cas =median(b3);
        das=mad(b3,1);
        d4=horzcat(d4,das);
        c4=horzcat(c4,cas);
        
    end
   bsa(i,1) = median(c1);
   csa(i,1) = mad(c1,1);
   bsa(i,2) = median(c2);
   csa(i,2) = mad(c2,1);
   bsa(i,3) = median(c3);
   csa(i,3) = mad(c3,1);
   bsa(i,4) = median(c4);
   csa(i,4) = mad(c4,1);
end
bsa=bsa';
csa =csa';
dlmwrite('binary_partscheme_median.txt',bsa);
dlmwrite('binary_partscheme_median.txt',csa,'-append');