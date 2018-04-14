function s
cmap = VOClabelcolormap();
pimap = part2ind();     % part index mapping
anno_files = 'partschange1.mat';
D = load(anno_files);
for i=1:length(D.s_annot)
    image=D.s_annot(i);
    name=image{1,1}.imname;
    year_num=name(1:4);
    file_id=name(6:length(name));
    str_img_path = sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s_%s.jpg',year_num,year_num,year_num,file_id);
    img = imread(str_img_path);
    subplot(1,2,1);imshow(img); 
    fprintf('Number of objects = %d\n',numel(image{1,1}.objects));
    for oo = 1:numel(image{1,1}.objects)
    obj = image{1,1}.objects(oo);
    silh = obj.mask;
    silh3 = uint8(repmat(silh,[1 1 3]));
    img_masked = silh3 .* img;
    [rrv,ccv] = find(silh);
    minR = min(rrv);
    minC = min(ccv);
    maxR = max(rrv);
    maxC = max(ccv);
    bb_width = maxC - minC + 1;
    bb_height = maxR - minR + 1;
    obj_masked = imcrop(img_masked,[minC minR bb_width bb_height]);
    subplot(1,2,2);imshow(obj_masked);
    fprintf('Number of parts in [%s] = [%d]\n',obj.class, numel(obj.parts));
    for pp = 1:numel(obj.parts)
        part_name = obj.parts(pp).partname;
        fprintf('Part [%d/%d] : %s\n',pp,numel(obj.parts),part_name);
         part_mask = obj.parts(pp).mask;
        [rrv,ccv] = find(part_mask);
        minR_p = min(rrv);
        minC_p = min(ccv);
        maxR_p = max(rrv);
        maxC_p = max(ccv);
        bb_width_p = maxC_p - minC_p + 1;
        bb_height_p = maxR_p - minR_p + 1;
        part_minC = minC_p - minC;
        part_minR = minR_p - minR;
       hold on;
        h2=subplot(1,2,2);rectangle('Position',[part_minC part_minR bb_width_p bb_height_p],'EdgeColor','r');
        text(part_minC+(bb_width_p/2), part_minR+(bb_height_p/2), sprintf('%s',part_name),'BackgroundColor',[.7 .9 .7],'Parent', h2);
        
    end
    hold off;
    end
end
end