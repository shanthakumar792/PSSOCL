%to get graphs for a particular scheme in a classifier.
function resultanalysis2
d='./results1';
di=dir(d);
num_cat=length(di)-2;
categories=[];
for i=1:num_cat
    cat=di(i+2).name;
    categories{i}=cat;
end
    cat=di(i+2).name;
    d2='./results1/cat';
    d3=dir(d2);
    kl=length(d3)-2;
    for j=1:kl
        scheme1=d3(j+2).name;
        Plot_data(categories,scheme1);
    end
end
