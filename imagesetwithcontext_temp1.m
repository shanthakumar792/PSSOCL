function imagesetwithcontext_temp1(cat,type)
di=sprintf('./myoutput1/%s/*.mat',cat);
d=dir(di);
num_annot=length(d);
u2=sprintf('./order/%s/%s.txt',cat,type);
fid=fopen(u2,'r');
partorder=textscan(fid,'%s','delimiter','\n');
fclose(fid);
mkdir('tobefed1',cat);
for i=1:num_annot-148
    name=d(i).name;
    u=sprintf('./myoutput1/%s/%s',cat,name);
    load(u);
    [rrv,ccv]=find(s.mask);
    [h,w]=size(s.mask);
    l2=s.mask(min(rrv):max(rrv),min(ccv):max(ccv));
    width=max(ccv)-min(ccv)+1;
    height=max(rrv)-min(rrv)+1;
    percent=0.18;
    extension_w=round(width*percent);
    extension_h=round(height*percent);
    left=min(ccv); right=max(ccv);
    up=min(rrv); down=max(rrv);
    left1=left;
    right1=right;
    up1=up;
    down1=down;
    k19=0; k20=0;
    l2(1:down-up+1,1:right-left+1)=1;
    if(left-extension_w>0)
        left1=left-extension_w;
        k19=1;
    end
    if(right+extension_w<=w)
        right1=right+extension_w;
        k19=1;
    end
    if(up-extension_h>0)
        up1=up-extension_h;
        k20=1;
    end
    if(down+extension_h<=h)
        down1=down+extension_h;
        k20=1;
    end
    imname=name(1:11);
    year=name(1:4);
    namestore=name(1:length(name)-4);
    s5=sprintf('../VOC%s/VOCdevkit/VOC%s/JPEGImages/%s.jpg',year,year,imname);
    img_1=imread(s5);
    img=img_1(up1:down1,left1:right1,:);
    [h1,w1,z1]=size(img);
    %u1=sprintf('./inputimages/%s/%s.png',cat,imname);
    %img=imread(u1);
    part=s.parts;
    s1=sprintf('tobefed1/%s',cat);
    mkdir(s1,namestore);
    s2=sprintf('tobefed1/%s/%s',cat,namestore);
    mkdir(s2,type);
    s3=sprintf('tobefed1/%s/%s/%s',cat,namestore,type);
    mkdir(s3,'with_context');
    part_mask=zeros(h1,w1);
    [h,w]=size(part_mask);
    l3=ones(h,w);
    l4=zeros(h,w);
    push_v=up-up1;
    push_h=left-left1;
    for x=1:height
        for y=1:width
            l4(push_v+x,push_h+y)=l2(x,y);
        end
    end
    left_over=l3-l4;
    A=1.*left_over;
    a=repmat(A,1,1,3);
    a=uint8(a);
    i1=img.*a;
    if(k19==1 || k20==1)
        s4=sprintf('tobefed1/%s/%s/%s/with_context/%d.png',cat,namestore,type,1);
        % imshow(i1);
        imwrite(i1,s4)
        part_mask=left_over;
        fprintf('Len = %d\n',length(partorder{1,1}));
        if( length(partorder{1,1}) ~= 9 )
            pause;
        end
        
        for j=1:length(partorder{1,1})
            for m=1:length(part)
                if(strcmp(part(m).partname,partorder{1,1}{j,1}))
                    lugh=1;
                    s8=part(m).mask;
                    if (m~=length(part))
                        for pas=m+1:length(part)
                            s8=s8-part(pas).mask;
                        end
                        
                        for pas1=1:height
                            for pas2=1:width
                                if(s8(pas1,pas2)==1)
                                    lugh=0;
                                    break;
                                end
                            end
                        end
                        for pas1=1:height
                            for pas2=1:width
                                if(s8(pas1,pas2)~=1)
                                    s8(pas1,pas2)=0;
                                end
                            end
                        end
                    end
                    if(lugh==1)
                        for x=1:height
                            for y=1:width
                                part_mask(push_v+x,push_h+y)=part_mask(push_v+x,push_h+y)+part(m).mask(x,y);
                            end
                        end
                    else
                        for x=1:height
                            for y=1:width
                                part_mask(push_v+x,push_h+y)=part_mask(push_v+x,push_h+y)+s8(x,y);
                            end
                        end
                    end
                end
            end
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
            i1=img.*a;
            s4=sprintf('tobefed1/%s/%s/%s/with_context/%d.png',cat,namestore,type,j+1);
            % imshow(i1);
            % pause;
            imwrite(i1,s4);
        end
        L=1.*(l4+left_over);
        l1=repmat(L,1,1,3);
        l1=uint8(l1);
        k=img.*l1;
        %imshow(k);
        %pause;
        s4=sprintf('tobefed1/%s/%s/%s/with_context/%d.png',cat,namestore,type,j+2);
        imwrite(k,s4);
    end
end
end
