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
    b3=[];
    b4=[];
    bk=[];
    b=[];
    classifier = a{i};
    for j=3:num_cat

        cat= di1(j).name;
        u = sprintf('./alexnetfinal2/%s',cat);
        dik = dir(u);
        num_scheme=length(dik);
        for k=3:num_scheme
            scheme = dik(k).name;
             u1=sprintf('./%s/%s/%s/without_context.mat',classifier,cat,scheme);
            ak = load(u1);
            if(i==1)
            b =horzcat(b,ak.h90);
            u2 = sprintf('./alexnetfinal1/%s/%s/without_context.mat',cat,scheme);
            aj = load(u2);            
            bk=horzcat(bk,aj.j90);
            elseif(i==2)
                 b =horzcat(b,ak.h91);
            u2 = sprintf('./googlenetfinal1/%s/%s/without_context.mat',cat,scheme);
            aj = load(u2);
            bk = horzcat(bk,aj.j91);
            elseif(i==3)
                b =horzcat(b,ak.h92);
                u2 = sprintf('./ninfinal1/%s/%s/without_context.mat',cat,scheme);
            aj = load(u2);
            bk = horzcat(bk,aj.j92);
            elseif(i==4)
                b =horzcat(b,ak.h93);
                u2 = sprintf('./vgg-19final1/%s/%s/without_context.mat',cat,scheme);
            aj = load(u2);
            bk = horzcat(bk,aj.j93);
            end  
            u1=sprintf('./%s/%s/%s/with_context.mat',classifier,cat,scheme);
            ak = load(u1);
            if(i==1)
            b =horzcat(b,ak.h90);
            u2 = sprintf('./alexnetfinal1/%s/%s/with_context.mat',cat,scheme);
            aj = load(u2);            
            bk=horzcat(bk,aj.j90);
            elseif(i==2)
                 b =horzcat(b,ak.h91);
            u2 = sprintf('./googlenetfinal1/%s/%s/with_context.mat',cat,scheme);
            aj = load(u2);
            bk = horzcat(bk,aj.j91);
            elseif(i==3)
                b =horzcat(b,ak.h92);
                u2 = sprintf('./ninfinal1/%s/%s/with_context.mat',cat,scheme);
            aj = load(u2);
            bk = horzcat(bk,aj.j92);
            elseif(i==4)
                b =horzcat(b,ak.h93);
                u2 = sprintf('./vgg-19final1/%s/%s/with_context.mat',cat,scheme);
            aj = load(u2);
            bk = horzcat(bk,aj.j93);
            end  
            u1=sprintf('./%s/%s/%s/blurcontext1.mat',classifier,cat,scheme);
            ak = load(u1);
            if(i==1)
            b =horzcat(b,ak.h90);
            u2 = sprintf('./alexnetfinal1/%s/%s/blurcontext1.mat',cat,scheme);
            aj = load(u2);            
            bk=horzcat(bk,aj.j90);
            elseif(i==2)
                 b =horzcat(b,ak.h91);
            u2 = sprintf('./googlenetfinal1/%s/%s/blurcontext1.mat',cat,scheme);
            aj = load(u2);
            bk = horzcat(bk,aj.j91);
            elseif(i==3)
                b =horzcat(b,ak.h92);
                u2 = sprintf('./ninfinal1/%s/%s/blurcontext1.mat',cat,scheme);
            aj = load(u2);
            bk = horzcat(bk,aj.j92);
            elseif(i==4)
                b =horzcat(b,ak.h93);
                u2 = sprintf('./vgg-19final1/%s/%s/blurcontext1.mat',cat,scheme);
            aj = load(u2);
            bk = horzcat(bk,aj.j93);
            end   
            u1=sprintf('./%s/%s/%s/blurcontext2.mat',classifier,cat,scheme);
            ak = load(u1);
            if(i==1)
            b =horzcat(b,ak.h90);
            u2 = sprintf('./alexnetfinal1/%s/%s/blurcontext2.mat',cat,scheme);
            aj = load(u2);            
            bk=horzcat(bk,aj.j90);
            elseif(i==2)
                 b =horzcat(b,ak.h91);
            u2 = sprintf('./googlenetfinal1/%s/%s/blurcontext2.mat',cat,scheme);
            aj = load(u2);
            bk = horzcat(bk,aj.j91);
            elseif(i==3)
                b =horzcat(b,ak.h92);
                u2 = sprintf('./ninfinal1/%s/%s/blurcontext2.mat',cat,scheme);
            aj = load(u2);
            bk = horzcat(bk,aj.j92);
            elseif(i==4)
                b =horzcat(b,ak.h93);
                u2 = sprintf('./vgg-19final1/%s/%s/blurcontext2.mat',cat,scheme);
            aj = load(u2);
            bk = horzcat(bk,aj.j93);
            end            
        end
    end
    x(i) = median(b);
    bs=1-bk;
    y(i) = sum(bs)/length(bs);
end
ajkl = horzcat(x',y');
    [R,P] = corrcoef(ajkl);
    ans1 = R(1,2);
    ans2 = P(1,2);