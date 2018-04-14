% this function stores .mat file objectwise for objects in the images
% intead of storing for multiple categories in a image. the mat files are
% put in appropriate folders each for a category.
function objectwiseannotate
anno_files = './Annotation/*.mat';
D1 = dir(anno_files);
h=zeros(13,1);
fid=fopen('shanthacatchange.txt','r');
cat=textscan(fid,'%s%s','delimiter',',');
fclose(fid);
h=zeros(13,1);
for i=1:length(D1)
    u=sprintf('Annotation/%s',D1(i).name);
    ann_file=D1(i).name;
    load(u);
    sname_annot1=[];
    for j=1:length(sname_annot)
        obj=sname_annot(j);
        catname=obj.class;
        for k=1:length(cat{1,2})
            if(strcmp(cat{1,2}{k,1},catname))
                h(k)=h(k)+1;
                 sname_annot1=obj;
                 u1=strcat(ann_file(1:length(ann_file)-4),'-');
                 u2=strcat(u1,num2str(h(k)));
                 u3=sprintf('Annotatedobjects/%s/%s',catname,u2);
                 save(u3,'sname_annot1','-v7.3');
            end
        end
    end
end
end