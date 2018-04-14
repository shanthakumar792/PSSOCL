function histo4
classifier='alexnet-top5';
cat='train';
cont='over-all.txt';
s2=sprintf('./partimportance1/%s/%s/%s',classifier,cat,cont);
fid=fopen(s2,'r');
weights=textscan(fid,'%f','delimiter','\n');
fclose(fid);
s3=sprintf('./partnames1/%s.txt',cat);
fid=fopen(s3,'r');
part=textscan(fid,'%s','delimiter','\n');
fclose(fid);
parts=part{1,1};
class_id_vec=1:length(parts);
class_vec=weights{1,1};
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
e
end