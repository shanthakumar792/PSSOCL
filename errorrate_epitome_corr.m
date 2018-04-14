%% This is for Section 1.4 in Supplement-C.
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
for i=1:length(a)
    context = a{i};
    b3=[];
    b4=[];
    bk=[];
    b=[];
    for j=3:num_cat
        
        
        cat= di1(j).name;
        u = sprintf('./alexnetfinal/%s',cat);
        dik = dir(u);
        num_scheme=length(dik);
        for k=3:num_scheme
            scheme = dik(k).name;
            u1=sprintf('./alexnetfinal2/%s/%s/%s.mat',cat,scheme,context);
            ak = load(u1);
            u2 = sprintf('alexnetfinal1/%s/%s/%s.mat',cat,scheme,context);
            aj = load(u2);
            b =horzcat(b,ak.h90);
            bk=horzcat(bk,aj.j90);
            u1=sprintf('./googlenetfinal2/%s/%s/%s.mat',cat,scheme,context);
            ak = load(u1);
            u2 = sprintf('googlenetfinal1/%s/%s/%s.mat',cat,scheme,context);
            aj = load(u2);            
            b =horzcat(b,ak.h91);
            bk = horzcat(bk,aj.j91);
            u1=sprintf('./ninfinal2/%s/%s/%s.mat',cat,scheme,context);
            ak = load(u1);
            b =horzcat(b,ak.h92);
            u2 = sprintf('ninfinal1/%s/%s/%s.mat',cat,scheme,context);
            aj = load(u2);
            bk = horzcat(bk,aj.j92);
            u1=sprintf('./vgg-19final2/%s/%s/%s.mat',cat,scheme,context);
            ak = load(u1);
            b =horzcat(b,ak.h93);
            u2 = sprintf('vgg-19final1/%s/%s/%s.mat',cat,scheme,context);
            aj = load(u2);
            bk = horzcat(bk,aj.j93);
        end       
    end    
    x(i) = median(b);
    bs=1-bk;
    y(i) = sum(bs)/length(bs);
    
end
ajkl = horzcat(x',y');
    [R,P] = corr(ajkl,'Type','Pearson');
    ans1 = R(1,2);
    ans2 = P(1,2);
[R,P] = corr(ajkl,'Type','Spearman');
    ans3 = R(1,2);
    ans4 = P(1,2);
    [R,P] = corr(ajkl,'Type','Kendall');
    ans5 = R(1,2);
    ans6 = P(1,2);