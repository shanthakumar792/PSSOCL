function imagecreator
di='./myoutput1/bicycle/*.mat';
d=dir(di);
num_annot=length(d);
for i=1:num_annot
    name=d(i).name;
    u=sprintf('myoutput1/bicycle/%s',name);
    load(u);
    u1=sprintf('inputimages/bicycle/%s.png',name(1:length(name)-4));
    img=imread(u1);
    imshow(img);
    hold on;
    part=s.parts;
    for j=1:length(part)
         pn=part(j).partname;
        part_mask=part(j).mask;
         A=255.*part_mask;
        s=strel('disk',1,0);%Structuring element
        D1=~im2bw(A);%binary Image
        F=imerode(D1,s);
        s1=D1-F;
        [rrv,ccv]=find(s1);
        plot(ccv,rrv,'r.');
    end
    hold off;
    pause;
end
end