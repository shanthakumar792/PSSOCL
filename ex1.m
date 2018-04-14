function ex1
x='./myannot/';
c=dir(x);
for i=3:length(c)
    n=c(i).name;
    y=sprintf('./myannot/%s',n);
    load(y)
end
l=1;
end