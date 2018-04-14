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
a{1} = 'without_context';
a{2} = 'with_context';
a{3} = 'blurcontext1';
a{4} = 'blurcontext2';
for i=1:length(a)
    v(i) = 0;
    b1=[];
    b2=[];
    b3=[];
    b4=[];
    b5=[];
    context = a{i};
    for j=3:num_cat
        s(j-2)=0;
        b=[];
        bk=[];
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
            if(j==3)
            s(j-2)=length(ak.h90);
            else
                s(j-2) = s(j-3) +length(ak.h90);
            end
            b =vertcat(b,ak.h90);
            bk=vertcat(bk,aj.j90);
            u1=sprintf('./googlenetfinal2/%s/%s/%s.mat',cat,scheme,context);
            ak = load(u1);
            u2 = sprintf('googlenetfinal1/%s/%s/%s.mat',cat,scheme,context);
            aj = load(u2);            
            b =vertcat(b,ak.h91);
            bk = vertcat(bk,aj.j91);
            u1=sprintf('./ninfinal2/%s/%s/%s.mat',cat,scheme,context);
            ak = load(u1);
            b =vertcat(b,ak.h92);
            u2 = sprintf('ninfinal1/%s/%s/%s.mat',cat,scheme,context);
            aj = load(u2);
            bk = vertcat(bk,aj.j92);
            u1=sprintf('./vgg-19final2/%s/%s/%s.mat',cat,scheme,context);
            ak = load(u1);
            b =vertcat(b,ak.h93);
            u2 = sprintf('vgg-19final1/%s/%s/%s.mat',cat,scheme,context);
            aj = load(u2);
            bk = vertcat(bk,aj.j93);
        end
        als = sprintf('./partspresentratio/%s.mat',cat);
        load(als)
        jkl=median(b);
        jklk = mad(b,1);
        jklk1 = mad(b);
        jklas = (median(bk));
        b1=horzcat(b1,jkl);
        b2 = horzcat(b2,jklk);
        b3 = horzcat(b3,jklas);
        b4 = horzcat(b4,asa);
        b5 = horzcat(b5,jklk1);
    end
    [x1,x2] = sort(b1);
    bsa = b2(x2);
    finalpred  = b3(x2);
    finalpart = b4(x2);
    a1 = horzcat(x1',finalpred');
    [R,P] = corr(a1,'Type','Pearson');
    ans1 = R(1,2);
    ans2 = P(1,2);
    [R,P] = corr(a1,'Type','Spearman');
    ans3 = R(1,2);
    ans4 = P(1,2);
    [R,P] = corr(a1,'Type','Kendall');
    ans5 = R(1,2);
    ans6 = P(1,2);
    a1 = horzcat(x1',finalpart');
    [R,P] = corr(a1,'Type','Pearson');
    ans7 = R(1,2);
    ans8 = P(1,2);
    [R,P] = corr(a1,'Type','Spearman');
    ans9 = R(1,2);
    ans10 = P(1,2);
    [R,P] = corr(a1,'Type','Kendall');
    ans11 = R(1,2);
    ans12 = P(1,2);
end
