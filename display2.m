function display2
cmap = VOClabelcolormap();
pimap = part2ind();     % part index mapping
anno_files = './Annotation_final/*.mat';
D = dir(anno_files);
 S{1}='r.';
 S{2}='b.';
 S{3}='g.';
 S{4}='m.';
 S{5}='c.';
 S{6}='y.';
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
    fprintf('Number of objects = %d\n',numel(sname_annot1));
    for oo = 1:numel(sname_annot1)
    obj = sname_annot1(oo);
    catname=obj.class;
    silh = obj.mask;
    h100=figure;
    silh3 = uint8(repmat(silh,[1 1 3]));
    img_masked = silh3 .* img;
    [rrv,ccv] = find(silh);
    minR = min(rrv);
    minC = min(ccv);
    maxR = max(rrv);
    maxC = max(ccv);
    bb_width = maxC - minC + 1;
    bb_height = maxR - minR + 1;
    obj_masked = imcrop(img,[minC minR bb_width bb_height]);
    I=obj_masked;
    [h,w]=size(I(:,:,1));
    for m=h+1:h+50
        for n=1:w
            I(m,n,:)=255;
        end
    end
    fprintf('Number of parts in [%s] = [%d]\n',obj.class, numel(obj.parts));
    imshow(I);
    l=0;
    hold on;
    for q=1:length(obj.toadd)
        text(4,h+(6*q),sprintf('%s',obj.toadd(q).parttobeadded),'FontSize',8);
    end
    for pp = 1:numel(obj.parts)
        part_name = obj.parts(pp).partname;
        fprintf('Part [%d/%d] : %s\n',pp,numel(obj.parts),part_name);
         part_mask = obj.parts(pp).mask;
        A=255.*part_mask;
        s=strel('disk',4,0);%Structuring element
        D1=~im2bw(A);%binary Image
        F=imerode(D1,s);
        s1=D1-F;
        [rrv,ccv]=find(s1);
        rrv=rrv-minR;
        ccv=ccv-minC;
        
         if(l>5)
             l=1;
         else
             l=l+1;
         end
        plot(ccv,rrv,S{l},'linewidth',0.5);
        pos1=round(mean(rrv));
        pos2=round(mean(ccv));
        text(pos2,pos1, sprintf('%s',part_name),'BackgroundColor',[.7 .9 .7]);
      
    end
    hold off;
    for O=1:13
        if strcmp(catname,l_1{O}.name)
            l_1{O}.count=l_1{O}.count+1;
            str_dest_path_100=sprintf('outputimages1/%s/%s_%d.png',catname,a1name,l_1{O}.count);
            saveTightFigure(h100,str_dest_path_100);
        end
    end
    close(h100);
    end
end
end
