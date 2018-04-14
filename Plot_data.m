% for plotting the 4 contextual graph 

function Plot_data(Categories,scheme1)

nClasses = length(Categories);
class_med_vec = zeros(1,nClasses);
class_mad_vec = zeros(1,nClasses);
scheme2='without_context';
for i = 1:nClasses
    u=sprintf('./resultsfinal/%s/%s/%s.mat',Categories{i},scheme1,scheme2);
    load(u);
    scr_i = h90; 
    class_med_vec(i) = median(scr_i);
    class_mad_vec(i) = std(scr_i)/sqrt(length(scr_i)); % standard error    
end
% Sort classes by their SCRs
[~,sorted_idx] = sort(class_med_vec);
class_med_vec = class_med_vec(sorted_idx);
class_mad_vec = class_mad_vec(sorted_idx);
h100=median(class_med_vec)
Categories = Categories(sorted_idx);
for i = 1:length(Categories)
    str = Categories{i};
    Categorie{i} = [str ' '];
end
figure(1);
class_id_vec = [1:length(Categorie)]; 
subplot(2,2,1); errorbar(class_id_vec,class_med_vec,class_mad_vec,'r.');
%errorbar_tick(h, 600);
xlim([0.9 length(Categorie)+0.1]);
ylim([0 1.05]);
set(gca,'XTickLabel',Categorie,'XTick',1:(numel(Categorie)));
rotateXLabels( gca(), 50);
scheme2='with_context';
for i = 1:nClasses
    u=sprintf('./resultsfinal/%s/%s/%s.mat',Categories{i},scheme1,scheme2);
    load(u);
    scr_i = h90; 
    class_med_vec(i) = median(scr_i);
    class_mad_vec(i) = std(scr_i)/sqrt(length(scr_i)); % standard error    
end
% Sort classes by their SCRs
[~,sorted_idx] = sort(class_med_vec);
class_med_vec = class_med_vec(sorted_idx);
class_mad_vec = class_mad_vec(sorted_idx);
Categories = Categories(sorted_idx);
h200=median(class_med_vec)
for i = 1:length(Categories)
    str = Categories{i};
    Categorie{i} = [str ' '];
end
class_id_vec = [1:length(Categorie)]; 
subplot(2,2,2); errorbar(class_id_vec,class_med_vec,class_mad_vec,'r.');
%errorbar_tick(h, 600);
xlim([0.9 length(Categorie)+0.1]);
ylim([0 1.05]);
set(gca,'XTickLabel',Categorie,'XTick',1:(numel(Categorie)));
rotateXLabels( gca(), 50);

scheme2='blurcontext1';
for i = 1:nClasses
    u=sprintf('./resultsfinal/%s/%s/%s.mat',Categories{i},scheme1,scheme2);
    load(u);
    scr_i = h90; 
    class_med_vec(i) = median(scr_i);
    class_mad_vec(i) = std(scr_i)/sqrt(length(scr_i)); % standard error    
end
% Sort classes by their SCRs
[~,sorted_idx] = sort(class_med_vec);
class_med_vec = class_med_vec(sorted_idx);
class_mad_vec = class_mad_vec(sorted_idx);
Categories = Categories(sorted_idx);
h300=median(class_med_vec)
for i = 1:length(Categories)
    str = Categories{i};
    Categorie{i} = [str ' '];
end
class_id_vec = [1:length(Categorie)]; 
subplot(2,2,3); errorbar(class_id_vec,class_med_vec,class_mad_vec,'r.');
%errorbar_tick(h, 600);
xlim([0.9 length(Categorie)+0.1]);
ylim([0 1.05]);
set(gca,'XTickLabel',Categories,'XTick',1:(numel(Categories)));
rotateXLabels( gca(), 50);
scheme2='blurcontext2';
for i = 1:nClasses
    u=sprintf('./resultsfinal/%s/%s/%s.mat',Categories{i},scheme1,scheme2);
    load(u);
    scr_i = h90; 
    class_med_vec(i) = median(scr_i);
    class_mad_vec(i) = std(scr_i)/sqrt(length(scr_i)); % standard error    
end
% Sort classes by their SCRs
[~,sorted_idx] = sort(class_med_vec);
class_med_vec = class_med_vec(sorted_idx);
class_mad_vec = class_mad_vec(sorted_idx);
Categories = Categories(sorted_idx);
h400=median(class_med_vec)
for i = 1:length(Categories)
    str = Categories{i};
    Categorie{i} = [str ' '];
end
class_id_vec = [1:length(Categorie)]; 
subplot(2,2,4); errorbar(class_id_vec,class_med_vec,class_mad_vec,'r.');
%errorbar_tick(h, 600);
xlim([0.9 length(Categorie)+0.1]);
ylim([0 1.05]);
set(gca,'XTickLabel',Categories,'XTick',1:(numel(Categories)));
rotateXLabels( gca(), 50);
set(1,'Position',[222 216 1121 529])
%grid on;