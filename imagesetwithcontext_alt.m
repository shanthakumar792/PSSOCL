function imagesetwithcontext_alt(cat)
type='alternate';
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
    s3=sprintf('tobefed/%s/%s/%s',cat,imname,type);
    mkdir(s3,'with_context');
    part_mask=zeros(size(part(1).mask));
    [h,w]=size(part_mask);
    l3=ones(h,w);
    left_over=l3-l2;
    A=1.*left_over;
    a=repmat(A,1,1,3);
    a=uint8(a);
    i1=img.*a;
    s4=sprintf('tobefed/%s/%s/%s/with_context/%d.png',cat,imname,type,1);
    imwrite(i1,s4)
    part_mask=left_over;
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
        A=1.*part_mask;
        a=repmat(A,1,1,3);
        a=uint8(a);
        i1=img.*a;
       s4=sprintf('tobefed/%s/%s/%s/with_context/%d.png',cat,imname,type,j+1);
       % imshow(i1);
       imwrite(i1,s4);
       
    end
    L=1.*(l2+left_over);
    l1=repmat(L,1,1,3);
    l1=uint8(l1);
    k=img.*l1;
    % imshow(k);
    s4=sprintf('tobefed/%s/%s/%s/with_context/%d.png',cat,imname,type,j+2);
    imwrite(k,s4);
end
end