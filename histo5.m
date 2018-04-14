function histo5
% over all classifiers each categories's part importance
cat='train';
cont='over-all.txt';
a{1}='alexnet-top5';
a{2}='googlenet-top5';
a{3}='vgg-19-top5';
a{4}='Nin-top5';
s3=sprintf('./partnames1/%s.txt',cat);
fid=fopen(s3,'r');
part=textscan(fid,'%s','delimiter','\n');
fclose(fid);
parts=part{1,1};
h=zeros(length(parts),1);
for i=1:4
    s2=sprintf('./partimportance1/%s/%s/%s',a{i},cat,cont);
    fid=fopen(s2,'r');
    w=textscan(fid,'%f','delimiter','\n');
    weights=w{1,1};
    fclose(fid);
    for j=1:length(parts)
        h(j)=h(j)+weights(j);
    end
end
class_vec=h;
class_id_vec=1:length(parts);
[~,sorted_idx] = sort(class_vec);
class_vec = class_vec(sorted_idx);
parts = parts(sorted_idx);
class_vec=class_vec/sum(class_vec);
e=0;
for i=1:length(parts)
    if(class_vec(i)~=0)
    e=e-(class_vec(i)*log2(class_vec(i)));
    end
end
s3=sprintf('./partimportance6/%s.txt',cat);
fid=fopen(s3,'w');
fprintf(fid,'%f\r\n',h);
fclose(fid);
end