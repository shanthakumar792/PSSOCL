function imageblur
type='length';
cat='car (sedan)';
di=sprintf('./myoutput1/%s/*.mat',cat);
d=dir(di);
num_annot=length(d);
u2=sprintf('./order/%s/%s.txt',cat,type);
fid=fopen(u2,'r');
partorder=textscan(fid,'%s','delimiter','\n');
fclose(fid);
mkdir('tobefed',cat);
for i=1:num_annot
    name=d(i).name;
    u=sprintf('./myoutput1/%s/%s',cat,name);
    load(u);
    [rrv,ccv]=find(s.mask);
    l2=s.mask(min(rrv):max(rrv),min(ccv):max(ccv));
    imname=name(1:length(name)-4);
    u1=sprintf('./inputimages/%s/%s.png',cat,imname);
    img=imread(u1);
    part=s.parts;
    s1=sprintf('tobefed/%s',cat);
    mkdir(s1,imname);
    s2=sprintf('tobefed/%s/%s',cat,imname);
    mkdir(s2,type);
   %s3=sprintf('tobefed/%s/%s/%s',cat,imname,type);
    %mkdir(s3,'blur1');
    a=27;
    b=47;
    w1=round(a+(b-a)*rand);
    h1=round(a+(b-a)*rand);
    alpha=10^(ceil(log(w1*h1)));
    K=alpha*rand(h1,w1);
    h=K/sum(sum(K));
    g=imfilter(img,h,'same');
    imshow(g);
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
       i1=g.*a1;
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