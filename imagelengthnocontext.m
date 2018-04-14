function imagelengthnocontext(cat,type)
di=sprintf('./newfinal/%s/*.mat',cat);
d=dir(di);
num_annot=length(d);
u2=sprintf('./order/%s/%s.txt',cat,type);
fid=fopen(u2,'r');
partorder=textscan(fid,'%s','delimiter','\n');
fclose(fid);
mkdir('tobefed1',cat);
for i=1:num_annot-145
    name=d(i).name;
    namestore=name(1:length(name)-4);
    imname=name(1:11);
    year=name(1:4);
     u=sprintf('tobefed1/%s',cat);
     mkdir(u,imname);
     u=sprintf('tobefed1/%s/%s',cat,namestore);
     mkdir(u,type);
     u=sprintf('tobefed1/%s/%s/%s',cat,namestore,type);
     mkdir(u,'nocontext');
    s5=sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s.jpg',year,year,imname);
    img_base=imread(s5);
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
    part_mask=zeros(size(mnew_final1(1).mask));
    p50=p50+1;
    u=sprintf('tobefed1/%s/%s/%s/nocontext/%d.png',cat,namestore,type,p50);
    imwrite(part_mask,u);
    for j=1:length(partorder{1,1})
        for m=1:length(part)
            if(strcmp(part(m).partname,partorder{1,1}{j,1}))
               part_mask=part_mask+mnew_final1(m).mask;
            end
        end
     for k=1:227
            for l=1:227
                if(part_mask(k,l)~=0)
                    part_mask(k,l)=1;
                end
            end
     end
     A=1.*part_mask;
        a=repmat(A,1,1,3);
        a=uint8(a);
        i1=final_obj1.*a;
        p50=p50+1;
    u=sprintf('tobefed1/%s/%s/%s/nocontext/%d.png',cat,namestore,type,p50);
    imwrite(i1,u);
       % imshow(i1);
    end
    A=1.*ff_2;
    a=repmat(A,1,1,3);
    a=uint8(a);
    i1=final_obj1.*a;
    p50=p50+1;
    u=sprintf('tobefed1/%s/%s/%s/nocontext/%d.png',cat,namestore,type,p50);
    imwrite(i1,u);
 %   imshow(i1);
  %  pause;
    else
       obj_new=img_base(up_orig:down_orig,left_orig:right_orig,:);
       ff_new=ff(up_orig:down_orig,left_orig:right_orig);
       part_mask=zeros(size(part(1).mask));
           p50=p50+1;
    u=sprintf('tobefed1/%s/%s/%s/nocontext/%d.png',cat,namestore,type,p50);
    imwrite(part_mask,u);
       for j=1:length(partorder{1,1})
        for m=1:length(part)
            if(strcmp(part(m).partname,partorder{1,1}{j,1}))
               part_mask=part_mask+part(m).mask;
            end
        end
        [h,w]=size(ff_new);
        for k=1:h
            for l=1:w
                if(part_mask(k,l)~=0)
                    part_mask(k,l)=1;
                end
            end
        end
        A=1.*part_mask;
        a=repmat(A,1,1,3);
        a=uint8(a);
        i1=obj_new.*a;
        p50=p50+1;
        u=sprintf('tobefed1/%s/%s/%s/nocontext/%d.png',cat,namestore,type,p50);
        imwrite(i1,u);
        %imshow(i1);
        %pause;
       end
       A=1.*ff_new;
       a=repmat(A,1,1,3);
       a=uint8(a);
       i1=obj_new.*a;
       p50=p50+1;
       u=sprintf('tobefed1/%s/%s/%s/nocontext/%d.png',cat,namestore,type,p50);
       imwrite(i1,u);
   %    imshow(i1);
    %   pause;
    end
end
end