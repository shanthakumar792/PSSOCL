function seeimages
cat = 'bicycle';
di=sprintf('./newfinal/%s/*.mat',cat);
d=dir(di);
type = 'saliencytype1';
num_annot=length(d);
u2=sprintf('./order/%s/%s.txt',cat,type);
fid=fopen(u2,'r');
partorder=textscan(fid,'%s','delimiter','\n');
fclose(fid);
mkdir('tobefed1',cat);
s311=sprintf('tobefed11/%s/%s.mat',type,cat);
condition1=load(s311);
for i=1:num_annot
    if(condition1.s999(i)==1)
    name=d(i).name;
    imname=name(1:11);
    namestore=name(1:length(name)-4);
    year=name(1:4);
    s5=sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s.jpg',year,year,imname);
    img_base=imread(s5);
    imshow(img_base);
    pause;
    end
end