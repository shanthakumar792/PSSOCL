function decreasingpartsize
cat='cat';
di=sprintf('./myoutput1/%s/*.mat',cat);
d=dir(di);
num_annot=length(d);
mkdir('tobefed',cat);
for i=1:num_annot
    name=d(i).name;
    u=sprintf('./myoutput1/%s/%s',cat,name);
    load(u);
    [rrv,ccv]=find(s.mask);
    l2=s.mask(min(rrv):max(rrv),min(ccv):max(ccv));
    [h,w]=size(l2);
    imname=name(1:length(name)-4);
    u1=sprintf('./inputimages/%s/%s.png',cat,imname);
    img=imread(u1);
    part=s.parts;
    s1=sprintf('tobefed/%s',cat);
    mkdir(s1,imname);
    s2=sprintf('tobefed/%s/%s',cat,imname);
    mkdir(s2,'decsize');
    s3=sprintf('tobefed/%s/%s/%s',cat,imname,'decsize');
    mkdir(s3,'without_context');
    size1=zeros(length(part),1);
    for j=1:length(part)
        m=part(j).mask;
        p=regionprops(m==1,'Area');
        size1(j)=p.Area;
    end
    part_mask=zeros(size(m));
    [b,I]=sort(size1,'descend');
    for j=1:length(part)
        name=part(I(j)).partname;
        part_mask=part_mask+part(I(j)).mask;
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
        s4=sprintf('tobefed/%s/%s/%s/without_context/%d.png',cat,imname,'decsize',j);
      %  imshow(i1);
      imwrite(i1,s4);
    end
    L=1.*l2;
    l1=repmat(L,1,1,3);
    l1=uint8(l1);
    k=img.*l1;
    %imshow(k);
    s4=sprintf('tobefed/%s/%s/%s/without_context/%d.png',cat,imname,'decsize',j+1);
    imwrite(k,s4);
end
end