%% This is for section A.2 in Supplement-E.
clc;
clear all;
close all;
d1 = './alexnet-top1';
d2 = './googlenet-top1';
d3 = './nin-top1';
d4 = './vgg-top1';
di1 = dir(d1);
di2 = dir(d2);
di3 = dir(d3);
di4 = dir(d4);
num_cat = length(di1);
for i=3:num_cat
    cat = di1(i).name;
    u4=sprintf('partnames1/%s.txt',cat);
    fid1=fopen(u4,'r');
    partn=textscan(fid1,'%s','delimiter','\n');
    k11=length(partn{1,1})+2;
    lpa(i-2) = k11;
end
M= max(lpa);
CLratio=[];
CLratio1=[];
CLratio2=[];
CLratio3=[];
CLratio4=[];
S=0;
CLA=0;
for i=3:num_cat
    cat = di1(i).name;
    cat
    u=sprintf('./alexnet-top1/%s',cat);
    dik = dir(u);
    u4=sprintf('partnames1/%s.txt',cat);
    fid1=fopen(u4,'r');
    partn=textscan(fid1,'%s','delimiter','\n');
    k11=length(partn{1,1})+2;
    num_scheme=length(dik);
    for j=3:num_scheme
        scheme=dik(j).name;
        u1=sprintf('./alexnet-top1/%s/%s',cat,scheme);
        dik1=dir(u1);
        num_context=length(dik1);
        for k=3:num_context
            context=dik1(k).name;
            u12=sprintf('alexnet-top1/%s/%s/%s',cat,scheme,context);
            u22=sprintf('googlenet-top1/%s/%s/%s',cat,scheme,context);
            u32=sprintf('nin-top1/%s/%s/%s',cat,scheme,context);
            u42=sprintf('vgg-top1/%s/%s/%s',cat,scheme,context);
            fid1=fopen(u12,'r');
            result1=textscan(fid1,'%s %s','delimiter',',');
            fclose(fid1);
            fid1=fopen(u22,'r');
            result2=textscan(fid1,'%s %s','delimiter',',');
            fclose(fid1);
            fid1=fopen(u32,'r');
            result3=textscan(fid1,'%s %s','delimiter',',');
            fclose(fid1);
            fid1=fopen(u42,'r');
            result4=textscan(fid1,'%s %s','delimiter',',');
            fclose(fid1);
            pk1 = result1{1,1};
            pj1 = result1{1,2};
            pk2 = result2{1,1};
            pj2 = result2{1,2};
            pk3 = result3{1,1};
            pj3 = result3{1,2};
            pk4 = result4{1,1};
            pj4 = result4{1,2};
            lk(1)=length(pj1);
            lk(2)=length(pj2);
            lk(3)=length(pj3);
            lk(4)=length(pj4);
            lkk=min(lk);
            for v1=1:k11:lkk
                S=S+1;
                start = v1;
                r1=[];
                r2=[];
                r3=[];
                r4=[];
                for v2=start:start+k11-1
                    %v2
                    r1(v2-start+1)=pj1{v2,1}-48;
                    r2(v2-start+1)=pj2{v2,1}-48;
                    r3(v2-start+1)=pj3{v2,1}-48;
                    r4(v2-start+1)=pj4{v2,1}-48;
                end
                i1 = 0;
                i2 = 0;
                for v2=1:k11
                spal = 0;
                pa =0;
                pk = 0;                    
                    if(v2==1)
                        if(r1(v2)==1)
                            i1=1;
                            i2=1;
                        end
                    elseif(v2~=k11)
                        if(r1(v2)==1 && i1~=0)
                            i1 = i1+1;
                        elseif(r1(v2)==1 && i1==0)
                            i1 = 1;
                            i2 = v2;
                        elseif(r1(v2) ==0 && i1 ~=0)
                            CL =i1;
                            TLR = k11-i2+1;                            
                            CLratio(i2,end+1)=CL/TLR;
                            CLratio1(i2,end+1) = CL/TLR;
                            pa = CL/TLR;
                            spal=i2;
                            i1=0;
                            i2=0;
                        end
                    else
                        if(r1(v2)==1 && i1~=0)
                            i1 = i1+1;
                            CL = i1;
                            TLR = k11-i2+1;
                            pa = CL/TLR;
                            spal = i2;
                            CLratio(i2,end+1) = CL /TLR;
                            CLratio1(i2,end+1) = CL/TLR;
                            i1 =0;
                            i2 =0;
                        elseif((r1(v2)==1) && (i1==0))
                            CLratio(v2,end+1) = 1;
                            CLratio1(v2,end+1) = CL/TLR;
                            spal = v2;
                            pa = 1;
                        end
                    end
                    if((spal>=(k11/2)) && (pa>=0.8) &&(pa<1))
                        CLA =CLA +1;
                    end
                end
                 i1 = 0;
                i2 = 0;
                for v2=1:k11
                    spal = 0;
                    pa =0;
                    pk = 0;
                    if(v2==1)
                        if(r2(v2)==1)
                            i1=1;
                            i2=1;
                        end
                    elseif(v2~=k11)
                        if(r2(v2)==1 && i1~=0)
                            i1 = i1+1;
                        elseif(r2(v2)==1 && i1==0)
                            i1 = 1;
                            i2 = v2;
                        elseif(r2(v2) ==0 && i1 ~=0)
                            CL =i1;
                            TLR = k11-i2+1;
                            spal = i2;
                            pa = CL/TLR;
                            CLratio(i2,end+1)=CL/TLR;
                            CLratio2(i2,end+1) = CL/TLR;
                            i1=0;
                            i2=0;
                        end
                    else
                        if(r2(v2)==1 && i1~=0)
                            i1 = i1+1;
                            CL = i1;
                            TLR = k11-i2+1;
                            spal =i2;
                            pa = CL/TLR;
                            CLratio(i2,end+1) = CL /TLR;
                            CLratio2(i2,end+1) = CL/TLR;
                            i1 =0;
                            i2 =0;
                        elseif((r2(v2)==1) && (i1==0))
                            spal = v2;
                            pa = 1;
                            CLratio(v2,end+1) = 1;
                            CLratio2(v2,end+1) = CL/TLR;
                        end
                    end
                    if((spal>=(k11/2)) && (pa>=0.8) &&(pa<1))
                        CLA =CLA +1;
                    end
                end
                i1 = 0;
                i2 = 0;
                for v2=1:k11
                    spal = 0;
                    pa =0;
                    pk = 0;
                    if(v2==1)
                        if(r3(v2)==1)
                            i1=1;
                            i2=1;
                        end
                    elseif(v2~=k11)
                        if(r3(v2)==1 && i1~=0)
                            i1 = i1+1;
                        elseif(r3(v2)==1 && i1==0)
                            i1 = 1;
                            i2 = v2;
                        elseif(r3(v2) ==0 && i1 ~=0)
                            CL =i1;
                            TLR = k11-i2+1;
                            spal = i2;
                            pa = CL/TLR;
                            CLratio(i2,end+1)=CL/TLR;
                            CLratio3(i2,end+1) = CL/TLR;
                            i1=0;
                            i2=0;
                        end
                    else
                        if(r3(v2)==1 && i1~=0)
                            i1 = i1+1;
                            CL = i1;
                            TLR = k11-i2+1;
                            spal = i2;
                            pa= CL/TLR;
                            CLratio(i2,end+1) = CL /TLR;
                            CLratio3(i2,end+1) = CL/TLR;
                            i1 =0;
                            i2 =0;
                        elseif((r3(v2)==1) && (i1==0))
                            spal = v2;
                            pa = 1;
                            CLratio(v2,end+1) = 1;
                            CLratio3(v2,end+1) = 1;
                        end
                    end
                    if((spal>=(k11/2)) && (pa>=0.8) &&(pa<1))
                        CLA =CLA +1;
                    end
                end
                i1 = 0;
                i2 = 0;
                
                for v2=1:k11
                    spal = 0;
                    pa =0;
                    pk = 0;
                    if(v2==1)
                        if(r4(v2)==1)
                            i1=1;
                            i2=1;
                        end
                    elseif(v2~=k11)
                        if(r4(v2)==1 && i1~=0)
                            i1 = i1+1;
                        elseif(r4(v2)==1 && i1==0)
                            i1 = 1;
                            i2 = v2;
                        elseif(r4(v2) ==0 && i1 ~=0)
                            CL =i1;
                            TLR = k11-i2+1;
                            spal = i2;
                            pa = CL/TLR;
                            CLratio(i2,end+1)=CL/TLR;
                            CLratio4(i2,end+1) = CL/TLR;
                            i1=0;
                            i2=0;
                        end
                    else
                        if(r4(v2)==1 && i1~=0)
                            i1 = i1+1;
                            CL = i1;
                            TLR = k11-i2+1;
                            spal = i2;
                            pa = CL/TLR;
                            CLratio(i2,end+1) = CL /TLR;
                            CLratio4(i2,end+1) = CL/TLR;
                            i1 =0;
                            i2 =0;
                        elseif((r4(v2)==1) && (i1==0))
                            spal = v2;
                            pa = 1;
                            CLratio(v2,end+1) = 1;
                            CLratio4(v2,end+1) = 1;
                        end
                    end
                    if((spal>=(k11/2)) && (pa>=0.8) &&(pa<1))
                        CLA =CLA +1;
                    end
                end
               
            end
        end
    end       
end
xbins = 0.1:0.1:1;
for i=1:13
    sk = CLratio(i,:);
    pos = find(sk~=0);
    a1 = CLratio(i,pos);
    a(i,:) = hist(a1,xbins);
end
for i=1:13
    sk = CLratio1(i,:);
    pos = find(sk~=0);
    a1 = CLratio1(i,pos);
    ak1(i,:) = hist(a1,xbins);    
end
for i=1:13
    sk = CLratio2(i,:);
    pos = find(sk~=0);
    a1 = CLratio2(i,pos);
    ak2(i,:) = hist(a1,xbins);    
end
for i=1:13
    sk = CLratio3(i,:);
    pos = find(sk~=0);
    a1 = CLratio3(i,pos);
    ak3(i,:) = hist(a1,xbins);    
end
for i=1:13
    sk = CLratio4(i,:);
    pos = find(sk~=0);
    a1 = CLratio4(i,pos);
    ak4(i,:) = hist(a1,xbins);    
end
ba = bar3(a);
for k = 1:length(ba)
    zdata = get(ba(k),'ZData');
    set(ba(k),'CData',zdata);
    set(ba(k),'FaceColor','interp');
end
xlabel('value range');
ylabel('positions of CLratio');
zlabel('Number of image sequences');
ax=gca;
set(ax,'XTickLabel',{'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1'})
colorbar