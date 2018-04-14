%this is for changing the partnames from PASCAL-VOC to our required names.

function s1
cmap = VOClabelcolormap();
pimap = part2ind();     % part index mapping
s_annot=[];
sname_annots = [];
sname_annots1 = [];
sname_annots2=[];
n=[];
anno_files = './Annotation_catchanged/*.mat';
D1 = dir(anno_files);
k=1;
for i=38:length(D1)
    ann_file=D1(i).name;
    load(sprintf('Annotation_catchanged/%s',ann_file));
     year_num = ann_file(1:4);
    file_id  = ann_file(6:end-4);
    str_img_path = sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s_%s.jpg',year_num,year_num,year_num,file_id);
     img = imread(str_img_path);
     for j=1:length(sketchname_annots.objects)
         catname=sketchname_annots.objects(j).class;
         mask1=sketchname_annots.objects(j).mask;
         str_parts_list_path = sprintf('partchange/%schange.txt',catname);
         str_parts_list_path1 = sprintf('partnames/%s.txt',catname);
         fid = fopen(str_parts_list_path,'r');
         parts=textscan(fid,'%s%s','delimiter',',');
         fclose(fid);
         fid1 = fopen(str_parts_list_path1,'r');
         parts1=textscan(fid1,'%s','delimiter','\n');
         fclose(fid1);
         v=0;
         obj=sketchname_annots.objects(j);
         for k=1:length(obj.parts)
             for t=1:length(parts{1,1})
                 if(strcmp(parts{1,1}{t,1},obj.parts(k).part_name))
                     v=v+1;
                     sname_annots(v).partname=parts{1,2}{t,1};
                     sname_annots(v).mask=obj.parts(k).mask;
                 end
             end
         end
         v=0;
         n=ones(length(parts1{1,1}),1);
         for k=1:length(parts1{1,1})
             for l=1:length(sname_annots)
                 if(strcmp(sname_annots(l).partname,parts1{1,1}{k,1}))
                     n(k)=0;
                 end
             end
         end
         for k=1:length(parts1{1,1})
             if(n(k)~=0)
               v=v+1;
               sname_annots2(v).parttobeadded=parts1{1,1}{k,1};
             end
         end
         sname_annots1(j).parts=sname_annots;
         sname_annots1(j).class=catname;
         sname_annots1(j).mask=mask1;
         sname_annots1(j).toadd=sname_annots2;
         sname_annots=[];
         sname_annots2=[];
     end
     u=sprintf('Annotation_partchanged/%s',ann_file);
     %save(u,'sname_annots1','-v7.3');
     per=zeros(size(img));
     [h,w,mas]=size(img);
     j=1;
     se=strel('disk',1);
     hold on;
     pee7(:,:,1)=uint8(zeros(size(sname_annots1(1).parts(1).mask)));
     for lk=10:length(sname_annots1(j).parts)
         pee7(:,:,1)=uint8(sname_annots1(j).parts(lk).mask);
         pee11(:,:,1)=pee7(:,:,1);
         pee12(:,:,1)=imerode(pee11(:,:,1),se);
         pee(:,:,2)=pee11(:,:,1)-pee12(:,:,1);
         khi(:,:,1)=uint8(pee7(:,:,1));
         khi(:,:,2)=khi(:,:,1);
         khi(:,:,3)=khi(:,:,1);
         pee1=(sname_annots1(j).parts(lk).partname);
         pee(:,:,1)=zeros(h,w);
         pee(:,:,3)=pee(:,:,1);
         pee=uint8(255*(pee));
         khi=uint8(khi*255);
         per(:,:,1)=per(:,:,1)+sname_annots1(j).parts(lk).mask;
         per(:,:,2)=per(:,:,2)+sname_annots1(j).parts(lk).mask;
         per(:,:,3)=per(:,:,3)+sname_annots1(j).parts(lk).mask;
         [rrv1,ccv1]=find(sname_annots1(j).parts(lk).mask);
         pos_x=round(mean(rrv1));
         pos_y=round(mean(ccv1));
         for lk1=1:h
             for lk2=1:w
                 if(per(lk1,lk2,1)>1)
                     per(lk1,lk2,1)=1;
                 end
                 if(per(lk1,lk2,2)>1)
                     per(lk1,lk2,2)=1;
                 end
                 if(per(lk1,lk2,3)>1)
                     per(lk1,lk2,3)=1;   
                 end
             end
         end
         per2=uint8(per);
         per1=img.*khi;
         per1=per1+pee;
         imshow(khi);
         %text(pos_y+20,pos_x,pee1,'color','yellow','FontSize',14);
         pause;
         
     end
     sname_annots1=[];
end
end