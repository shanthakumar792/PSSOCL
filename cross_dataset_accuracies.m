%% File to run Table 1 is this. 
clc;
clear all;
close all;
d1 = './vgg-top1';
scheme = 'saliencytype1';
context = 'with_context';
di1 = dir(d1);
num_cat = length(di1);
for i=3:num_cat
    cat = di1(i).name;
    m14=sprintf('alexnetfinal1/%s/%s/%s.mat',cat,scheme,context);
    m24=sprintf('googlenetfinal1/%s/%s/%s.mat',cat,scheme,context);
    m34=sprintf('ninfinal1/%s/%s/%s.mat',cat,scheme,context);
    m44=sprintf('vgg-19final1/%s/%s/%s.mat',cat,scheme,context);
    load(m14);
    load(m24);
    load(m34);
    load(m44);
    s1(i-2) = sum(j90)/length(j90);
    s2(i-2) = sum(j91)/length(j91);
    s3(i-2) = sum(j92)/length(j92);
    s4(i-2) = sum(j93)/length(j93);
end
alexnet= s1';
googlenet= s2';
nin= s3';
vgg19= s4';
p = table(alexnet,googlenet,nin,vgg19);
x(1,1) = median(alexnet);
y(1,1) = mad(alexnet);
x(2,1) = median(googlenet);
y(2,1) = mad(googlenet);
x(3,1) = median(nin);
y(3,1) = mad(nin);
x(4,1) = median(vgg19);
y(4,1) = mad(vgg19);
med_value = x;
mad_value = y;
a = table(med_value,mad_value);
writetable(p,'Individual_count.txt','Delimiter',' ');
writetable(a,'cumulative_count.txt','Delimiter',' ');