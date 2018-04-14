% This script loads masked (w.r.t original pic) images.
% The images are resized to a fixed dimension and saved to a directory.
% Parsing the image filename provides details of object category
% Last number in the filename is the class id. This class id is
% according to ordering given by PASCAL-part team and not to be
% confused with the class id provided for sketches by Eitz et al.

load('PASCAL_parts_obj_level.mat');
disp('loaded');
NUM_RESIZE_ROWS = 128;
NUM_RESIZE_COLS = 128;
for i = 1:length(all_annots)
    fprintf('Saving images in %d of %d\n',i,length(all_annots));        
    for j = 1:length(all_annots{i}.objs_info)        
        str = sprintf('pascal-parts-masked/pascal-parts-%d-%d-%d.jpg',i,j,all_annots{i}.objs_info(j).obj_class_ind);
        Img_in = all_annots{i}.objs_info(j).obj_img;
        [rows,cols,channels] = size(Img_in);
        maxDim = max(rows,cols);
        Img_out = uint8(zeros(maxDim,maxDim,channels));
        Img_out(1:rows,1:cols,:) = Img_in;
        Img_out = imresize(Img_out,[NUM_RESIZE_ROWS NUM_RESIZE_COLS]);
        imwrite(Img_out,str);                
    end
end
