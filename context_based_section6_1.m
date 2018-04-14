%% Table 2 Main paper. Also for Supplementary E Table2 (Change input file) 
clc;
clear all;
close all;
d1 = './alexnetfinal2';
d2 = './googlenetfinal2';
d3 = './ninfinal2';
d4 = './vgg19final2';
di1 = dir(d1);
di2 = dir(d2);
di3 = dir(d3);
di4 = dir(d4);
num_cat = length(di1);
a{1} = 'without_context';
a{2} = 'with_context';
a{3} = 'blurcontext1';
a{4} = 'blurcontext2';
for i=1:4
    context = a{i};
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
        u = sprintf('./alexnetfinal2/%s',cat);
        dik = dir(u);
        num_scheme=length(dik);
        for k=3:num_scheme
            scheme = dik(k).name;
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
bsa = bsa';
csa = csa';
