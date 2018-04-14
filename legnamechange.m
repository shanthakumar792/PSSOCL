

% thisis used for only merging upper and lower part of left or right legs
% respectively and renaming it as left leg or right leg.uses alphavol() to
% get a continuous region.


function legnamechange
cmap = VOClabelcolormap();
pimap = part2ind();     % part index mapping
anno_files = './Annotation_partchanged/*.mat';
D = dir(anno_files);
s_annot=[];
sname_annots = [];
sname_annots100 = [];
for i=38:length(D)
    ann_file=D(i).name;
    load(sprintf('Annotation_partchanged/%s',ann_file));
     year_num = ann_file(1:4);
    file_id  = ann_file(6:end-4);
    str_img_path = sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s_%s.jpg',year_num,year_num,year_num,file_id);
    img = imread(str_img_path);
    imshow(img);
     for j=1:length(sname_annots1)
         parts=sname_annots1(j).parts;
         n1=zeros(1,length(parts));
         m=[];m1=[];m2=[];m3=[];m4=[];m5=[];
         n2=n1;
         n3=n1;
         n4=n1;
         p1=n1;
         p2=n1;
         v=0;
         catname=sname_annots1(j).class;
         mask55=sname_annots1(j).mask;
         if(strcmp(catname,'cow')|strcmp(catname,'sheep')|strcmp(catname,'horse'))
             for k=1:length(parts)
                 name=parts(k).partname;
                 if(strcmp(name,'lbleg'))
                     n1(k)=1;
                 end
                 if(strcmp(name,'lfleg'))
                     n2(k)=1;
                 end
                 if(strcmp(name,'rbleg'))
                     n3(k)=1;
                 end
                 if(strcmp(name,'rfleg'))
                     n4(k)=1;
                 end
             end
         elseif(strcmp(catname,'person walking'))
             for k=1:length(parts)
                 name=parts(k).partname;
                 if(strcmp(name,'lleg'))
                     p1(k)=1;
                 end
                 if(strcmp(name,'rleg'))
                     p2(k)=1;
                 end
          
            end
         end
         l1=0;l2=0;l3=0;l4=0;l5=0;l6=0;
         l1=length(find(n1));
         if(l1>1)
             s1=find(n1);
             k1=(s1(1));k2=(s1(2));
             mask1=parts(k1).mask;
             mask2=parts(k2).mask;
             mask13=mask1+mask2;
             [m1(:,1),m1(:,2)]=ind2sub(size(mask13),find(mask13));
             [a99,b100,a100] = compactalpha(m1,0);
             masknew1=getin(mask13,b100,m1);
         end
         l2=length(find(n2));
          if(l2>1)
             s2=find(n2);
             k3=(s2(1));k4=(s2(2));
             mask3=parts(k3).mask;
             mask4=parts(k4).mask;
             mask14=mask3+mask4;
             [m2(:,1),m2(:,2)]=ind2sub(size(mask14),find(mask14));
             [a99,b100,a100] = compactalpha(m2,0);
             masknew2=getin(mask14,b100,m2);
         end
         l3=length(find(n3));
          if(l3>1)
             s3=find(n3);
             k5=(s3(1));k6=(s3(2));
             mask5=parts(k5).mask;
             mask6=parts(k6).mask;
             mask15=mask5+mask6;
             [m3(:,1),m3(:,2)]=ind2sub(size(mask15),find(mask15));
             [a99,b100,a100] = compactalpha(m3,0);
             masknew3=getin(mask15,b100,m3);
         end
         l4=length(find(n4));
          if(l4>1)
             s4=find(n4);
             k7=(s4(1));k8=(s4(2));
             mask7=parts(k7).mask;
             mask8=parts(k8).mask;
             mask16=mask7+mask8;
             [m4(:,1),m4(:,2)]=ind2sub(size(mask16),find(mask16));
             [a99,b100,a100] = compactalpha(m4,0);
             masknew4=getin(mask16,b100,m4);
         end
         l5=length(find(p1));
         if(l5>1)
             s5=find(p1);
             k9=(s5(1));k10=(s5(2));
             mask9=parts(k9).mask;
             mask10=parts(k10).mask;
             mask18=mask9+mask10;
             [m(:,1),m(:,2)]=ind2sub(size(mask18),find(mask18));
             [a99,b100,a100] = compactalpha(m,0);
             masknew=getin(mask18,b100,m);
         end
         l6=length(find(p2));
         if(l6>1)
              s6=find(p2);
             k11=(s6(1));k12=(s6(2));
             mask11=parts(k11).mask;
             mask12=parts(k12).mask;
             mask17=mask11+mask12;
             [m5(:,1),m5(:,2)]=ind2sub(size(mask17),find(mask17));
             [a99,b100,a100] = compactalpha(m5,0);
              masknew5=getin(mask17,b100,m5);
         end
         
         for k=1:length(parts)
             v=v+1;
             sname_annots(v).partname=parts(k).partname;
             sname_annots(v).mask=parts(k).mask;
           if(n1(k)~=0 && l1>1)
             sname_annots(v).partname='leg';
             sname_annots(v).mask=masknew1;
           elseif (n1(k)~=0 && l1==1)
             sname_annots(v).partname='leg';
             sname_annots(v).mask=parts(k).mask;
           end
              if(n2(k)~=0 && l2>1)
             sname_annots(v).partname='leg';
             sname_annots(v).mask=masknew2;
           elseif (n2(k)~=0 && l2==1)
             sname_annots(v).partname='leg';
             sname_annots(v).mask=parts(k).mask;
              end
              if(n3(k)~=0 && l3>1)
             sname_annots(v).partname='leg';
             sname_annots(v).mask=masknew3;
           elseif (n3(k)~=0 && l3==1)
             sname_annots(v).partname='leg';
             sname_annots(v).mask=parts(k).mask;
              end
              if(n4(k)~=0 && l4>1)
             sname_annots(v).partname='leg';
             sname_annots(v).mask=masknew4;
           elseif (n4(k)~=0 && l4==1)
             sname_annots(v).partname='leg';
             sname_annots(v).mask=parts(k).mask;
              end
              if(p1(k)~=0 && l5>1)
             sname_annots(v).partname='leg';
             sname_annots(v).mask=masknew;
           elseif (p1(k)~=0 && l5==1)
             sname_annots(v).partname='leg';
             sname_annots(v).mask=parts(k).mask;
              end
              if(p2(k)~=0 && l6>1)
             sname_annots(v).partname='leg';
             sname_annots(v).mask=masknew5;
           elseif (p2(k)~=0 && l6==1)
             sname_annots(v).partname='leg';
             sname_annots(v).mask=parts(k).mask;
              end 
         end
         sname_annots100(j).parts=sname_annots;
         sname_annots100(j).class=catname;
         sname_annots100(j).mask=mask55;
         sname_annots=[];
     end
     u=sprintf('Annotation_legnamechange/%s',ann_file);
     %save(u,'sname_annots100','-v7.3');
     per=zeros(size(img));
     [h,w,mas]=size(img);
     j=1;
     se=strel('disk',1);
     if(length(sname_annots100(j).parts)>0)
     for lk=1:length(sname_annots100(j).parts)
         pee8(:,:,2)=uint8(sname_annots100(j).parts(lk).mask);
         pee9(:,:,2)=imerode(pee8(:,:,2),se);
         pee(:,:,2)=pee8(:,:,2)-pee9(:,:,2);
         khi(:,:,1)=uint8(pee8(:,:,2));
         khi(:,:,2)=khi(:,:,1);
         khi(:,:,3)=khi(:,:,1);
         pee1=(sname_annots100(j).parts(lk).partname);
         pee(:,:,1)=zeros(h,w);
         pee(:,:,3)=pee(:,:,1);
         pee=uint8(255*(pee));
         khi=uint8(khi*255);
         per(:,:,1)=per(:,:,1)+sname_annots100(j).parts(lk).mask;
         per(:,:,2)=per(:,:,2)+sname_annots100(j).parts(lk).mask;
         per(:,:,3)=per(:,:,3)+sname_annots100(j).parts(lk).mask;
         [rrv1,ccv1]=find(sname_annots100(j).parts(lk).mask);
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
         close all;
     end
     end
     sname_annots100=[];
end

end
function mnew=getin(maskold,b100,s)
idx=b100.bnd;
sf=[s(idx(:,1),1) s(idx(:,2),2)];
xv=sf(:,1);
yv=sf(:,2);
v=0;
[k1,k2]=size(maskold);
mnew=zeros(k1,k2);
p=zeros(k1*k2,2);
for i=1:k1
    for j=1:k2
        v=v+1;
        p(v,1)=i;
        p(v,2)=j;
    end
end
xn=p(:,1);
yn=p(:,2);
[in,on]=inpolygon(xn,yn,xv,yv);
s3=xn(in);
s5=yn(in);
for i=1:numel(s3)
    mnew(s3(i),s5(i))=1;
end
end