% this function is to change the partnames from their existing partnames to
% the partnames given to us sketch epitome scores.

function s2
cmap = VOClabelcolormap();
pimap = part2ind();     % part index mapping
anno_files = './Annotation_legnamechange/*.mat';
D = dir(anno_files);
sname_annot=[];
sname_annot1=[];
sname_annot2=[];
for i=1:length(D)
    ann_file=D(i).name;
    load(sprintf('Annotation_legnamechange/%s',ann_file));
     year_num = ann_file(1:4);
    file_id  = ann_file(6:end-4);
    str_img_path = sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s_%s.jpg',year_num,year_num,year_num,file_id);
     img = imread(str_img_path);
     for j=1:length(sname_annots100)
         catname=sname_annots100(j).class;
         mask1=sname_annots100(j).mask;
         parts=sname_annots100(j).parts;
         n1=zeros(length(parts),1);
         str_parts_list_path1 = sprintf('partnames/%s.txt',catname);
         fid1 = fopen(str_parts_list_path1,'r');
         parts1=textscan(fid1,'%s','delimiter','\n');
         fclose(fid1);
         v=0;
         if ((strcmp(catname,'horse') || strcmp(catname,'cow') || strcmp(catname,'sheep') || strcmp(catname,'person walking')) && length(parts)>1 )
         for k1=1:(length(parts)-1)
             for k2=k1+1:length(parts)
                 if(strcmp(parts(k1).partname,'leg') && isequal(logical(parts(k1).mask),logical(parts(k2).mask)) && strcmp(parts(k2).partname,'leg') )
                    n1(k1)=1; n1(k2)=1;
                    v=v+1;
                    sname_annot(v).partname='leg';
                    sname_annot(v).mask=logical(parts(k1).mask);
                 end
             end
         end
         if length(find(n1))
         for p=1:length(parts)
            if(p~=find(n1))
                v=v+1;
                sname_annot(v).partname=parts(p).partname;
                sname_annot(v).mask=parts(p).mask;
            end
         end
         else
             for k1=1:length(parts)
                 v=v+1;
                 sname_annot(v).partname=parts(k1).partname;
                 sname_annot(v).mask=parts(k1).mask;
             end
         end
         else
             for k1=1:length(parts)
                 v=v+1;
                 sname_annot(v).partname=parts(k1).partname;
                 sname_annot(v).mask=parts(k1).mask;
             end
         end
          n=ones(length(parts1{1,1}),1);
         for k=1:length(parts1{1,1})
             for l=1:length(sname_annot)
                 if(strcmp(sname_annot(l).partname,parts1{1,1}{k,1}))
                     n(k)=0;
                 end
             end
         end
         h=0;
         for k=1:length(parts1{1,1})
             if(n(k)~=0)
               h=h+1;
               sname_annot2(h).parttobeadded=parts1{1,1}{k,1};
             end
         end
         sname_annot1(j).parts=sname_annot;
         sname_annot1(j).class=catname;
         sname_annot1(j).mask=mask1;
         sname_annot1(j).toadd=sname_annot2;
         sname_annot2=[];
         sname_annot=[];
     end
     u=sprintf('Annotation_final/%s',ann_file);
    % save(u,'sname_annot1','-v7.3');
     sname_annot1=[];
end
end