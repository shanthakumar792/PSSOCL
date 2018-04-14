function blurfinal_length1(cat,type)
di=sprintf('./newfinal/%s/*.mat',cat);
d=dir(di);
num_annot=length(d);
u2=sprintf('./order/%s/%s.txt',cat,type);
fid=fopen(u2,'r');
partorder=textscan(fid,'%s','delimiter','\n');
fclose(fid);
mkdir('tobefed1',cat);
s311=sprintf('tobefed11/%s/%s.mat',type,cat);
condition1=load(s311);
for i=18:num_annot
    if(condition1.s999(i)==1)
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
    mkdir(u,'blurcontext1');
    u=sprintf('./newfinal/%s/%s',cat,name);
    load(u);
    ff=v1.mask;
    part=v1.parts;
    [rrv,ccv]=find(v1.mask);
    left_orig=min(ccv); right_orig=max(ccv);
    up_orig=min(rrv); down_orig=max(rrv);
    obj_old=img_base(up_orig:down_orig,left_orig:right_orig,:);
    p50=0;
    if(1==0)
        up_new=v1.dim(1); down_new=v1.dim(2);
        left_new=v1.dim(3); right_new=v1.dim(4);
        obj_new=img_base(round(up_new):round(down_new),round(left_new):round(right_new),:);
        ff_new=ff(round(up_new):round(down_new),round(left_new):round(right_new));
        [h1,w1,z1]=size(obj_new);
        part_template=zeros(h1,w1);
        xpad=round(left_orig-left_new);
        ypad=round(up_orig-up_new);
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
        u=sprintf('tobefed1/%s/%s/%s/blurcontext1/%d.png',cat,namestore,type,p50);
        %  imwrite(p,u);
        %figure;
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
            u=sprintf('tobefed1/%s/%s/%s/blurcontext1/%d.png',cat,namestore,type,p50);
            % imwrite(p1,u);
            %     figure;
                  imshow(p1);
             pause;
        end
        p50=p50+1;
        u=sprintf('tobefed1/%s/%s/%s/blurcontext1/%d.png',cat,namestore,type,p50);
        %imwrite(final_obj1,u);
        %figure;
        imshow(final_obj1);
         pause;
    else
        part_mask=zeros(size(part(1).mask));
        part_mask2=zeros(size(part(1).mask));
        [h,w]=size(part(1).mask);
        t1=[];
        s1=[];
        j=1;
        %    p = svistest(obj_old,part_mask2,1);
        [h9,w9]=size(obj_old);
        gh1=fspecial('gaussian',[round(h9/2),round(w9/2)],10.0);
        p=imfilter(obj_old,gh1,'same');
        p50=p50+1;
        u=sprintf('tobefed1/%s/%s/%s/blurcontext1/%d.png',cat,namestore,type,p50);
        %imwrite(p,u);
        % figure;
            imshow(p);
            pause;
        for j=1:length(partorder{1,1})
            for m=1:length(part)
                if(strcmp(part(m).partname,partorder{1,1}{j,1}))
                    lugh=1;
                    s8=part(m).mask;
                    if (m~=length(part))
                        for pas=m+1:length(part)
                            s8=s8-part(pas).mask;
                        end
                        
                        for pas1=1:h
                            for pas2=1:w
                                if(s8(pas1,pas2)==1)
                                    lugh=0;
                                    break;
                                end
                            end
                        end
                        for pas1=1:h
                            for pas2=1:w
                                if(s8(pas1,pas2)~=1)
                                    s8(pas1,pas2)=0;
                                end
                            end
                        end
                    end
                    if (lugh==1)
                        part_mask=part_mask+part(m).mask;
                    else
                        part_mask=part_mask+s8;
                    end
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
            u=sprintf('tobefed1/%s/%s/%s/blurcontext1/%d.png',cat,namestore,type,p50);
            %imwrite(p1,u);
            %figure;
            imshow(p1);
              pause;
        end
        p50=p50+1;
        u=sprintf('tobefed1/%s/%s/%s/blurcontext1/%d.png',cat,namestore,type,p50);
        %imwrite(obj_old,u);
        %figure;
         imshow(obj_old);
          pause;
    end
end
end
end
