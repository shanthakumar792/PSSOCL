function shantha2
% This takes annotations provided by PASCAL-part team and 
% images from VOC datasets as input. The output is a list
% of masked (w.r.t original pic) object images along with 
% bounding box information of parts present in the object

%this is for changing the category names from PASCAL-VOC to our required
%one in sketch part annotations.

cmap = VOClabelcolormap();
pimap = part2ind();     % part index mapping
anno_files = './Annotations_Part/*.mat';
D = dir(anno_files);
sketchname_annots = [];
fid=fopen('shanthacatchange.txt','r');
cat=textscan(fid,'%s%s','delimiter',',');
fclose(fid);
for i = 3:(length(D)-10000)
    fprintf('%d of %d\n',i-2,length(D)-2);
    ann_file = D(i).name;
    t=0;
    v=0;
    % load annotation -- anno
    load(sprintf('Annotations_Part/%s',ann_file));
    for k=1:length(anno.objects)
        
         for j=1:length(cat{1,1})
        
            if(strcmp(anno.objects(k).class,cat{1,1}{j,1}))
                v=v+1;
                sketchname_annots.objects(v).class=cat{1,2}{j,1};
                sketchname_annots.objects(v).parts=anno.objects(k).parts;
                sketchname_annots.objects(v).class_ind=anno.objects(k).class_ind;
                sketchname_annots.objects(v).mask=anno.objects(k).mask;
                sketchname_annots.imname=anno.imname;
                t=1;
            end
         end
    end
    v=0;
   if(t==1)
       u=sprintf('Annotation_catchanged/%s',ann_file);
       save(u,'sketchname_annots','-v7.3');
   end
    sketchname_annots=[];
   %year_num = ann_file(1:4);
    %file_id  = ann_file(6:end-4);
    %str_img_path = sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s_%s.jpg',year_num,year_num,year_num,file_id);
    %img = imread(str_img_path);
   % curr_img_objs = GetPartInfo(anno, img, pimap,ann_file,str_img_path);
    % all_annots{i-2} = curr_img_objs;
end
end