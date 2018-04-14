function classifierperform
classifier='nin';
M=[137,114,145,132,130,111,132,131,136,192,131,133];
ix=min(M);
cat{1}='airplane.mat';
cat{2}='bicycle.mat';
cat{3}='bird.mat';
cat{4}='bus.mat';
cat{5}='car.mat';
cat{6}='cat.mat';
cat{7}='cow.mat';
cat{8}='dog.mat';
cat{9}='horse.mat';
cat{10}='person.mat';
cat{11}='sheep.mat';
cat{12}='train.mat';
for k=1:100
for i=1:length(M)
    fg(i,:)=randperm(M(i),ix);
end
for i=1:length(M)
    u=sprintf('googlenetfinal2/%s',cat{i});
    load(u);
    arraypresent=fg(i,:);
    c1(i)=0;
    for j=1:length(arraypresent)
        c1(i)=c1(i)+any(ismember(arraypresent(j),e2));
    end
end
C=sum(c1);
acc(k)=C/(ix*length(M));
end
accfinal=median(acc)
devia=std(acc)
end