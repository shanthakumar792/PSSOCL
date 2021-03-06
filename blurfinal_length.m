function blurfinal_length(cat,type)
di=sprintf('./newfinal/%s/*.mat',cat);
d=dir(di);
num_annot=length(d);
u2=sprintf('./order/%s/%s.txt',cat,type);
fid=fopen(u2,'r');
partorder=textscan(fid,'%s','delimiter','\n');
fclose(fid);
mkdir('tobefed1',cat);
u=sprintf('tobefed1/%s',cat);
h1000=dir(u);
num_annot=length(h1000);
for i=1:num_annot
    name=d(i).name;
    imname=name(1:11);
    namestore=name(1:length(name)-4);
    year=name(1:4);
    s5=sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s.jpg',year,year,imname);
    img_base=imread(s5);
    u=sprintf('tobefed1/%s',cat);
    mkdir(u,namestore);
    u=sprintf('tobefed1/%s/%s',cat,namestore);
    mkdir(u,type);
    u=sprintf('tobefed1/%s/%s/%s',cat,namestore,type);
    mkdir(u,'blurcontext');
    u=sprintf('./newfinal/%s/%s',cat,name);
    load(u);
    ff=v1.mask;
    part=v1.parts;
    [rrv,ccv]=find(v1.mask);
    left_orig=min(ccv); right_orig=max(ccv);
    up_orig=min(rrv); down_orig=max(rrv);
    obj_old=img_base(up_orig:down_orig,left_orig:right_orig,:);
    p50=0;
    if(~isempty(v1.dim))
    up_new=v1.dim(1); down_new=v1.dim(2);
    left_new=v1.dim(3); right_new=v1.dim(4);
    obj_new=img_base(up_new:down_new,left_new:right_new,:);
    ff_new=ff(up_new:down_new,left_new:right_new);
    [h1,w1,z1]=size(obj_new);
    part_template=zeros(h1,w1);
    xpad=left_orig-left_new;
    ypad=up_orig-up_new;
     for j=1:length(part)
        m1=part(j).mask;
        mnew1=part_template;
        [hp,wp]=size(m1);
        for o1=1:hp
            for o2=1:wp
                mnew1(ypad+o1,xpad+o2)=m1(o1,o2);
            end
        end
        mnew(j).mask=mnew1;
    end
    if(h1>w1)
        w2=227;
        h2=(h1/w1)*227;
    else
        h2=227;
        w2=(w1/h1)*227;
    end
    final_obj=imresize(obj_new,[h2,w2]);
    ff_1=imresize(ff_new,[h2,w2]);
  %  final_obj=repmat(final_obj,[1,1,3]);
    for j=1:length(part)
        mnew_final(j).mask=imresize(mnew(j).mask,[h2,w2]);
    end
    if(h2>w2)
        h_mid=round(h2/2);
        final_obj1=final_obj(h_mid-113:h_mid+113,1:227,:);
         ff_2=ff_1(h_mid-113:h_mid+113,1:227);
        for j=1:length(part)
            mnew_final1(j).mask=mnew_final(j).mask(h_mid-113:h_mid+113,1:227);
        end
    else
        w_mid=round(w2/2);
        final_obj1=final_obj(1:227,w_mid-113:w_mid+113,:);
        ff_2=ff_1(1:227,w_mid-113:w_mid+113);
        for j=1:length(part)
            mnew_final1(j).mask=mnew_final(j).mask(1:227,w_mid-113:w_mid+113);
        end
    end
     part_mask=zeros(size(mnew_final1(1)));
     part_mask2=zeros(size(mnew_final1(1)));
     t1=[];
     s1=[];
     j=1;
   %p = svistest(final_obj1,part_mask2,1);
   [h9,w9]=size(final_obj1);
   gh1=fspecial('gaussian',[round(h9/5) round(w9/5)],10.0);
   p=imfilter(final_obj1,gh1,'same');
   p50=p50+1;
    u=sprintf('tobefed1/%s/%s/%s/blurcontext/%d.png',cat,namestore,type,p50);
  %  imwrite(p,u);
   imshow(p);
   pause;
     for j=1:length(partorder{1,1})
        for m=1:length(part)
            if(strcmp(part(m).partname,partorder{1,1}{j,1}))
               part_mask=part_mask+mnew_final1(m).mask;
            end
        end
        p = svistest(final_obj1,part_mask,2);
        p1=zeros(size(p));
        t1{j}=p;
        s1{j}=part_mask;
        [rrv1,ccv1]=find(part_mask);
        p1=p;
        for j11=1:length(rrv1)
        p1(rrv1(j11),ccv1(j11),:)=final_obj1(rrv1(j11),ccv1(j11),:);
        end
        p50=p50+1;
        u=sprintf('tobefed1/%s/%s/%s/blurcontext/%d.png',cat,namestore,type,p50);
        %imwrite(p1,u);
        imshow(p1);
        pause;
     end
     p50=p50+1;
     u=sprintf('tobefed1/%s/%s/%s/blurcontext/%d.png',cat,namestore,type,p50);
    % imwrite(final_obj1,u);
     imshow(final_obj1);
     pause;
    else
        part_mask=zeros(size(part(1).mask));
        part_mask2=zeros(size(part(1).mask));
        t1=[];
        s1=[];
        j=1;
    %    p = svistest(obj_old,part_mask2,1);
      [h9,w9]=size(obj_old);
      gh1=fspecial('gaussian',[round(h9/2),round(w9/2)],10.0);
      p=imfilter(obj_old,gh1,'same');
      p50=p50+1;
      u=sprintf('tobefed1/%s/%s/%s/blurcontext/%d.png',cat,namestore,type,p50);
     % imwrite(p,u);
        imshow(p);
        pause;
        for j=1:length(partorder{1,1})
         for m=1:length(part)
            if(strcmp(part(m).partname,partorder{1,1}{j,1}))
               part_mask=part_mask+part(m).mask;
            end
         end
        p = svistest(obj_old,part_mask,2);
        t1{j}=p;
        s1{j}=part_mask;
        p1=p;
        [rrv1,ccv1]=find(part_mask);
        for j11=1:length(rrv1)
        p1(rrv1(j11),ccv1(j11),:)=obj_old(rrv1(j11),ccv1(j11),:);
        end
        p50=p50+1;
        u=sprintf('tobefed1/%s/%s/%s/blurcontext/%d.png',cat,namestore,type,p50);
      %  imwrite(p1,u);
        imshow(p1);
        pause;
        end
       p50=p50+1;
       u=sprintf('tobefed1/%s/%s/%s/blurcontext/%d.png',cat,namestore,type,p50);
   %    imwrite(obj_old,u);
     imshow(obj_old);
     pause;
    end
end
end