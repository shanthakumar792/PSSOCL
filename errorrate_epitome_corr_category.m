clc;
clear all;
close all;
d1 = './alexnetfinal';
d2 = './googlenetfinal';
d3 = './ninfinal';
d4 = './vgg19final';
di1 = dir(d1);
di2 = dir(d2);
di3 = dir(d3);
di4 = dir(d4);
num_cat = length(di1);
for i=3:num_cat
    bk=[];
    b=[];
    cat = di1(i).name;
    u = sprintf('./alexnetfinal/%s',cat);
    dik = dir(u);
    num_scheme=length(dik); 
    for j=3:num_scheme
        scheme = dik(j).name;
        u10 = sprintf('./alexnetfinal/%s/%s',cat,scheme);
        dik1 = dir(u10);
        num_context = length(dik1);
        for k=3:num_context
            context = dik1(k).name;
            context = context(1:length(context)-4);
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
    x(i-2) = median(b);
    bs=1-bk;
    y(i-2) = sum(bs)/length(bs);
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