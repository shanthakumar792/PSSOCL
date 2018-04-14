clc;
clear all;
close all;
cat = 'train';
type = 'alternate';
di = sprintf('./newfinal/%s/*.mat',cat);
d=dir(di);
di1 = sprintf('./order/%s/%s.txt',cat,type);
fid=fopen(di1,'r');
partorder=textscan(fid,'%s','delimiter','\n');
fclose(fid);
m = length(partorder{1,1});
ob_hist = zeros(m,1);
num_annot=length(d);
da =0;
mik = sprintf('./partspresentratio');
mik1 = sprintf('./partspresentratio/%s.mat',cat);
asa=[];
for i =1:num_annot
    %if(i~=0)
    n = d(i).name;
    u=sprintf('./newfinal/%s/%s',cat,n);
    v1 = load(u);
    s1 = v1.v1.parts;
    [rrv,ccv] = find(v1.v1.mask);
    [h,w] = size(v1.v1.mask);
    width=max(ccv)-min(ccv)+1;
    height=max(rrv)-min(rrv)+1;
    percent=0.18;
    extension_w=round(width*percent);
    extension_h=round(height*percent);
    left=min(ccv); right=max(ccv);
    up=min(rrv); down=max(rrv);
    left1=left;
    right1=right;
    up1=up;
    down1=down;
    k19=0; k20=0;
    l2(1:down-up+1,1:right-left+1)=1;
    if(left-extension_w>0)
        left1=left-extension_w;
        k19=1;
    end
    if(right+extension_w<=w)
        right1=right+extension_w;
        k19=1;
    end
    if(up-extension_h>0)
        up1=up-extension_h;
        k20=1;
    end
    if(down+extension_h<=h)
        down1=down+extension_h;
        k20=1;
    end
    if(k19==1 || k20 ==1)
        da = da+1;
        loh =1;
    for j = 1:length(s1)
        aj = s1(j).partname;
        lop = 0;
        if(j>1 && (strcmp(aj,'Select ..')==0))
            for k = 1:j-1
                ak = s1(k).partname;
                if (strcmp(ak,aj))
                    lop = 1;
                    break;
                end
            end
        
        if (lop ==0)
            loh = loh+1;
        end
        end
    end
    asa(da) = loh/m;
    ob_hist(loh) = ob_hist(loh) +1;
    end
end
save(mik1,'asa','-v7.3');
ob_histx = ob_hist/da;
bar(ob_histx)
title(cat)