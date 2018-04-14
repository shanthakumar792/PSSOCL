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
a{1} = 'alexnetfinal';
a{2} = 'googlenetfinal';
a{3} = 'ninfinal';
a{4} = 'vgg-19final';
for i=1:length(a)
    b1=[];
    b2=[];
    b3=[];
    b4=[];
    classifier = a{i};
    for j=3:num_cat
        b=[];
        bk=[];
        cat= di1(j).name;
        u = sprintf('./alexnetfinal2/%s',cat);
        dik = dir(u);
        num_scheme=length(dik);
        for k=3:num_scheme
            scheme = dik(k).name;
            u1=sprintf('./%s/%s/%s/without_context.mat',classifier,cat,scheme);
            ak = load(u1);
            if(i==1)
            b =vertcat(b,ak.h90);
            elseif(i==2)
                 b =vertcat(b,ak.h91);
            elseif(i==3)
                b =vertcat(b,ak.h92);
            elseif(i==4)
                b =vertcat(b,ak.h93);
            end
            u1=sprintf('./%s/%s/%s/with_context.mat',classifier,cat,scheme);
            ak = load(u1);
            if(i==1)
            b =vertcat(b,ak.h90);
            elseif(i==2)
                 b =vertcat(b,ak.h91);
            elseif(i==3)
                b =vertcat(b,ak.h92);
            elseif(i==4)
                b =vertcat(b,ak.h93);
            end
            u1=sprintf('./%s/%s/%s/blurcontext1.mat',classifier,cat,scheme);
            ak = load(u1);
            if(i==1)
            b =vertcat(b,ak.h90);
            elseif(i==2)
                 b =vertcat(b,ak.h91);
            elseif(i==3)
                b =vertcat(b,ak.h92);
            elseif(i==4)
                b =vertcat(b,ak.h93);
            end 
            u1=sprintf('./%s/%s/%s/blurcontext2.mat',classifier,cat,scheme);
            ak = load(u1);
            if(i==1)
            b =vertcat(b,ak.h90);
            u2 = sprintf('./alexnetfinal1/%s/%s/blurcontext2.mat',cat,scheme);
            aj = load(u2);            
            bk=vertcat(bk,aj.j90);
            elseif(i==2)
                 b =vertcat(b,ak.h91);
            u2 = sprintf('./googlenetfinal1/%s/%s/blurcontext2.mat',cat,scheme);
            aj = load(u2);
            bk = vertcat(bk,aj.j91);
            elseif(i==3)
                b =vertcat(b,ak.h92);
                u2 = sprintf('./ninfinal1/%s/%s/blurcontext2.mat',cat,scheme);
            aj = load(u2);
            bk = vertcat(bk,aj.j92);
            elseif(i==4)
                b =vertcat(b,ak.h93);
                u2 = sprintf('./vgg-19final1/%s/%s/blurcontext2.mat',cat,scheme);
            aj = load(u2);
            bk = vertcat(bk,aj.j93);
            end            
        end
        jkl=median(b);
        jklk = mad(b,1);
        b1=horzcat(b1,jkl);
        b2 = horzcat(b2,jklk);
        jklas = median(bk);
        b3= horzcat(b3,jklas);
        als = sprintf('./partspresentratio/%s.mat',cat);
        load(als)
        b4 = horzcat(b4,asa);
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