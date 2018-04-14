%this is to add new field called fileid which is set to 0 when going
%through each object.

function fileid
cmap = VOClabelcolormap();
pimap = part2ind();     % part index mapping
anno_files = './Annotation_final/*.mat';
D = dir(anno_files);
sname_annot=[];
for i=1:length(D)
    ann_file=D(i).name;
    a1name=ann_file(1:length(ann_file)-4);
    load(sprintf('Annotation_final/%s',ann_file));
     year_num = ann_file(1:4);
    file_id  = ann_file(6:end-4);
    str_img_path = sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s_%s.jpg',year_num,year_num,year_num,file_id);
    for oo = 1:numel(sname_annot1)
     obj = sname_annot1(oo);
     sname_annot(oo).parts=obj.parts;
     sname_annot(oo).class=obj.class;
     sname_annot(oo).mask=obj.mask;
     sname_annot(oo).toadd=obj.toadd;
     sname_annot(oo).fileid=0;
    end
    u=sprintf('Annotation/%s',ann_file);
  %  save(u,'sname_annot','-v7.3');
    sname_annot=[];
end
end