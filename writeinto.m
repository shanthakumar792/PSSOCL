% this function writes the address of every image in the particular
% category and in particular scheme into a file to be later fed into the
% classifier.
function writeinto
cat='cat';
fid=fopen('addresses.txt','w');
di=sprintf('./tobefed1/%s/*',cat);
sch1='temporal';
sch2='nocontext';
d=dir(di);
u=sprintf('/home/shanthakumar/tobefed1/%s/%s/%s/%s',cat,d(1).name,sch1,sch2);
%fprintf(fid,'%s\r\n',u);
num_images=length(d);
for i=1:num_images
    name1=d(i).name;
    u=sprintf('./tobefed1/%s/%s/%s/%s/*.png',cat,name1,sch1,sch2);
    d1=dir(u);
    num_sequence=length(d1);
    for j=1:num_sequence
     u1=sprintf('/home/shanthakumar/tobefed1/%s/%s/%s/%s/%d.png',cat,name1,sch1,sch2,j);  
   %  fprintf(fid,'%s\r\n',u1);
    end
end
fclose(fid);
end