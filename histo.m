function histo
% generate context based graph
classifier='vgg-19-top5';
class_id_vec=[1:4];
categories{1}='withoutcontext';
categories{2}='withcontext';
categories{3}='blurhigh';
categories{4}='blurlow';
s=sprintf('./shantha_result_2/%s/context_based_median.txt',classifier);
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