function histo2
%generate category based graph
classifier='alexnet-top5';
class_id_vec=[1:12];
categories{1}='airplane';
categories{2}='bicycle';
categories{3}='bird';
categories{4}='bus';
categories{5}='car';
categories{6}='cat';
categories{7}='cow';
categories{8}='dog';
categories{9}='horse';
categories{12}='train';
categories{11}='sheep';
categories{10}='person';
s=sprintf('./shantha_result_2/%s/category_based_median.txt',classifier);
fid=fopen(s,'r');
order=textscan(fid,'%f %f','delimiter','\n');
a=order{1,1};
b=order{1,2};
[~,sorted_idx]=sort(a);
a=a(sorted_idx);
b=b(sorted_idx);
categories=categories(sorted_idx);
errorbar(class_id_vec,a,b,'r.');
ylim([0 1.05]);
set(gca,'XTickLabel',categories,'XTick',1:(numel(categories)));
rotateXLabels( gca(), 50);
end