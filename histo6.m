function histo6
%generate part scheme based graph
classifier='alexnet-top5';
class_id_vec=[1:4];
categories{1}='length';
categories{2}='random';
categories{3}='saliencytype1';
categories{4}='saliencytype2';
s=sprintf('./shantha_result_2/%s/partscheme_based_median.txt',classifier);
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