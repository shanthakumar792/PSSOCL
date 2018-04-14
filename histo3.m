function histo3
classifier='Nin-top5';
cat='train';
cont{3}='blurcontext1.txt';
cont{4}='blurcontext2.txt';
cont{2}='with_context.txt';
cont{1}='without_context.txt';
s3=sprintf('./partnames1/%s.txt',cat);
fid=fopen(s3,'r');
part=textscan(fid,'%s','delimiter','\n');
fclose(fid);
parts=part{1,1};
s2=sprintf('./partimportance/%s/%s/%s',classifier,cat,cont{1});
fid=fopen(s2,'r');
weights=textscan(fid,'%f','delimiter','\n');
fclose(fid);
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
subplot(2,2,1);
plot(class_id_vec,class_vec,'r*');
xlim([0.9 length(parts)+0.1]);
set(gca,'XTickLabel',parts,'XTick',1:(numel(parts)));
s3=sprintf('./partnames1/%s.txt',cat);
fid=fopen(s3,'r');
part=textscan(fid,'%s','delimiter','\n');
fclose(fid);
parts=part{1,1};
s2=sprintf('./partimportance/%s/%s/%s',classifier,cat,cont{2});
fid=fopen(s2,'r');
weights=textscan(fid,'%f','delimiter','\n');
fclose(fid);
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
subplot(2,2,2);
plot(class_id_vec,class_vec,'r*');
xlim([0.9 length(parts)+0.1]);
set(gca,'XTickLabel',parts,'XTick',1:(numel(parts)));
s3=sprintf('./partnames1/%s.txt',cat);
fid=fopen(s3,'r');
part=textscan(fid,'%s','delimiter','\n');
fclose(fid);
parts=part{1,1};
s2=sprintf('./partimportance/%s/%s/%s',classifier,cat,cont{3});
fid=fopen(s2,'r');
weights=textscan(fid,'%f','delimiter','\n');
fclose(fid);
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
subplot(2,2,3);
plot(class_id_vec,class_vec,'r*');
xlim([0.9 length(parts)+0.1]);
set(gca,'XTickLabel',parts,'XTick',1:(numel(parts)));
s3=sprintf('./partnames1/%s.txt',cat);
fid=fopen(s3,'r');
part=textscan(fid,'%s','delimiter','\n');
fclose(fid);
parts=part{1,1};
s2=sprintf('./partimportance/%s/%s/%s',classifier,cat,cont{4});
fid=fopen(s2,'r');
weights=textscan(fid,'%f','delimiter','\n');
fclose(fid);
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
subplot(2,2,4);
plot(class_id_vec,class_vec,'r*');
xlim([0.9 length(parts)+0.1]);
set(gca,'XTickLabel',parts,'XTick',1:(numel(parts)));
end