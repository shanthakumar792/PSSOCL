function imageintofolders
cmap = VOClabelcolormap();
pimap = part2ind();     % part index mapping
anno_files = './Annotation_final/*.mat';
D = dir(anno_files);
 l_1{1}.name='airplane';
 l_1{1}.count=0;
 l_1{2}.name='bicycle';
 l_1{2}.count=0;
 l_1{3}.name='bus';
 l_1{3}.count=0;
 l_1{4}.name='car (sedan)';
 l_1{4}.count=0;
 l_1{5}.name='cat';
 l_1{5}.count=0;
 l_1{6}.name='cow';
 l_1{6}.count=0;
 l_1{7}.name='dog';
 l_1{7}.count=0;
 l_1{8}.name='horse';
 l_1{8}.count=0;
 l_1{9}.name='flying bird';
 l_1{9}.count=0;
 l_1{10}.name='person walking';
 l_1{10}.count=0;
 l_1{11}.name='potted plant';
 l_1{11}.count=0;
 l_1{12}.name='sheep';
 l_1{12}.count=0;
 l_1{13}.name='train';
 l_1{13}.count=0;
for i=1:length(D)
    ann_file=D(i).name;
    a1name=ann_file(1:length(ann_file)-4);
    load(sprintf('Annotation_final/%s',ann_file));
     year_num = ann_file(1:4);
    file_id  = ann_file(6:end-4);
    str_img_path = sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s_%s.jpg',year_num,year_num,year_num,file_id);
     img = imread(str_img_path);
     for oo = 1:numel(sname_annot1)
     obj = sname_annot1(oo);
     catname=obj.class;
      silh = obj.mask;
    silh3 = uint8(repmat(silh,[1 1 3]));
    img_masked = silh3 .* img;
    [rrv,ccv] = find(silh);
    minR = min(rrv);
    minC = min(ccv);
    maxR = max(rrv);
    maxC = max(ccv);
    bb_width = maxC - minC ;
    bb_height = maxR - minR;
    obj_masked = imcrop(img,[minC minR bb_width bb_height]);
    I=obj_masked;
    for O=1:13
        if strcmp(catname,l_1{O}.name)
            l_1{O}.count=l_1{O}.count+1;
            n9=sprintf('%s-%d',a1name,l_1{O}.count);
            str_dest_path_100=sprintf('inputimages/%s/%s.png',catname,n9);
            imwrite(I,str_dest_path_100);
        end
    end
   
     end
end
end