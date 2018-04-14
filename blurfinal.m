function blurfinal
type='length';
cat='cat';
di=sprintf('./myoutput1/%s/*.mat',cat);
d=dir(di);
num_annot=length(d);
u2=sprintf('./order/%s/%s.txt',cat,type);
fid=fopen(u2,'r');
partorder=textscan(fid,'%s','delimiter','\n');
fclose(fid);
mkdir('tobefed',cat);
for i=1:num_annot
    clear fin;
    name=d(i).name;
    u=sprintf('./myoutput1/%s/%s',cat,name);
    load(u);
    [rrv,ccv]=find(s.mask);
    l2=s.mask(min(rrv):max(rrv),min(ccv):max(ccv));
    l1=ones(size(l2));
    imname=name(1:length(name)-4);
    u1=sprintf('./inputimages/%s/%s.png',cat,imname);
    img=imread(u1);
    part=s.parts;
    s1=sprintf('tobefed/%s',cat);
    mkdir(s1,imname);
    s2=sprintf('tobefed/%s/%s',cat,imname);
    mkdir(s2,type);
    h=fspecial('gaussian',[25 25],20);
    h1=fspecial('gaussian',[35 35],30);
    h2=fspecial('gaussian',[50 50],35);
    h3=fspecial('gaussian',[60 60],40);
    h4=fspecial('gaussian',[15 15],15);    
    g=imfilter(img,h,'same');
    g1=imfilter(img,h1,'same');
    g2=imfilter(img,h2,'same');
    g3=imfilter(img,h3,'same');
    g4=imfilter(img,h4,'same');
   s=strel('disk',10);
   s1=strel('disk',20);
   s2=strel('disk',30);
   l3=imdilate(l2,s);
   l4=imdilate(l2,s1);
   l5=imdilate(l2,s2);
   iout=l1-l5;
   iout1=l5-l4;
   iout2=l4-l3;
   iout3=l3-l2;
   iout4=l2;
   [rrv1,ccv1]=find(iout);
   [rrv2,ccv2]=find(iout1);
   [rrv3,ccv3]=find(iout2);
   [rrv4,ccv4]=find(iout3);
   [rrv5,ccv5]=find(iout4);
   svistest(img);
   pause;
   part_mask=zeros(size(part(1).mask));
    [h,w]=size(part_mask);
    l3=ones(h,w);
    for j=1:length(partorder{1,1})   
      for m=1:length(part)
        if(strcmp(part(m).partname,partorder{1,1}{j,1}))
         part_mask=part_mask+part(m).mask;
        end
      end
       for k=1:h
            for l=1:w
                if(part_mask(k,l)~=0)
                    part_mask(k,l)=1;
                end
            end
       end
       left_over=l3-part_mask;
       A=1.*left_over;
       a1=repmat(A,1,1,3);
       a1=uint8(a1);
       i1=y1.*a1;
       A1=1.*part_mask;
       a2=repmat(A1,1,1,3);
       a2=uint8(a2);
       i2=img.*a2;
       i3=i1+i2;
       imshow(i3);
       pause;
    end
    imshow(img);
    pause;
end
end