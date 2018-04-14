%% This is for table 3. Answer is in variable bol.
clc;
clear all;
close all;
d1 = './alexnetfinal';
di1 = dir(d1);
num_cat = length(di1);
for i=3:num_cat
    a{i-2}=di1(i).name;
end
for i=1:12
    bol(i)=0;
    cat = a{i};
    u = sprintf('./alexnetfinal/%s',cat);
    dik = dir(u);
    num_scheme = length(dik);
        b=[];
        b1=[];
        b2=[];
        b3=[];
        c1=[];
        c2=[];
        c3=[];
    for j=3:num_scheme
        
        scheme = dik(j).name;
        u1 = sprintf('./alexnetfinal/%s/%s',cat,scheme);
        dik1 = dir(u1);
        num_context=length(dik1);
        for k=3:num_context
            context = dik1(k).name;
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
    end
    c(1) =median(b);
    d(1) = mad(b);
    c(2) = median(b1);
    d(2) = mad(b2);
    c(3) = median(b2);
    d(3) = mad(b2);
    c(4)=median(b3);
    d(4) = mad(b3);
    [val,pos] = max(c);
    bol(i)=pos;
    
end