function demo2
% This takes annotations provided by PASCAL-part team and 
% images from VOC datasets as input. The output is a list
% of masked (w.r.t original pic) object images along with 
% bounding box information of parts present in the object

cmap = VOClabelcolormap();
pimap = part2ind();     % part index mapping
anno_files = './Annotations_Part/*.mat';
D = dir(anno_files);
all_annots = [];
for i = 3:(length(D)-10000)
    fprintf('%d of %d\n',i-2,length(D)-2);
    ann_file = D(i).name;
    % load annotation -- anno
    load(sprintf('Annotations_Part/%s',ann_file));
    year_num = ann_file(1:4);
    file_id  = ann_file(6:end-4);
    str_img_path = sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s_%s.jpg',year_num,year_num,year_num,file_id);
    img = imread(str_img_path);
    subplot(1,2,1);imshow(img);    
    curr_img_objs = GetPartInfo(anno, img, pimap,ann_file,str_img_path);
    all_annots{i-2} = curr_img_objs;
    pause;
end

%save('PASCAL_parts_obj_level.mat','all_annots', '-v7.3');

end

function [all_objs_info] = GetPartInfo(anno, img, pimap, ann_file, str_img_path)

all_objs_info.ann_file = ann_file;
all_objs_info.img_file = str_img_path;
objs_info = struct([]);
fprintf('Number of objects = %d\n',numel(anno.objects));
for oo = 1:numel(anno.objects)
    obj = anno.objects(oo);
    class_ind = obj.class_ind;
    silh = obj.mask;            % the silhouette mask of the object
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
    a=1;
    subplot(1,2,2);imshow(obj_masked); hold on;
    objs_info(oo).obj_bb = [minC minR bb_width bb_height];
    objs_info(oo).obj_img = obj_masked;
    objs_info(oo).obj_class_ind = class_ind;
    objs_info(oo).obj_class = obj.class;
    fprintf('Number of parts in [%s] = [%d]\n',obj.class, numel(obj.parts));
    objs_info(oo).num_parts = numel(obj.parts);
    part_info = struct([]);
    for pp = 1:numel(obj.parts)
        part_name = obj.parts(pp).part_name;
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
        h2=subplot(1,2,2);rectangle('Position',[part_minC part_minR bb_width_p bb_height_p],'EdgeColor','r');
        text(part_minC+(bb_width_p/2), part_minR+(bb_height_p/2), sprintf('%s',part_name),'BackgroundColor',[.7 .9 .7],'Parent', h2);
        part_info(pp).part_name = part_name;
        pid = pimap{class_ind}(part_name);
        part_info(pp).part_id = pid;
        part_info(pp).part_bb = [part_minC part_minR bb_width_p bb_height_p];
        pause;
    end
    objs_info(oo).part_info = part_info;
    hold off;
end
all_objs_info.objs_info = objs_info;

end
