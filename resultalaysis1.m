% to find the category epitomes in the obtained result data from the
% classifier and to store them. make sure before running the program to change the names of
% categories from already existing to the new one given in the partnames
% folder.
function resultalaysis1
d='./alexnet';
di=dir(d);
num_cat=length(di);
d1='./googlenet';
di1=dir(d1);
d2='./nin';
di2=dir(d2);
d3='./vgg-19';
di3=dir(d3);
for i=3:num_cat
    cat=di(i).name;
    cat
    u=sprintf('./alexnet/%s',cat);
    di1=dir(u);
    u4=sprintf('partnames1/%s.txt',cat);
    fid1=fopen(u4,'r');
    partn=textscan(fid1,'%s','delimiter','\n');
    k11=length(partn{1,1})+2;
    num_scheme=length(di1);
    m11=sprintf('alexnetfinal/%s',cat);
    m21=sprintf('googlenetfinal/%s',cat);
    m31=sprintf('ninfinal/%s',cat);
    m41=sprintf('vgg-19final/%s',cat);
    m13=sprintf('alexnetfinal1/%s',cat);
    m23=sprintf('googlenetfinal1/%s',cat);
    m33=sprintf('ninfinal1/%s',cat);
    m43=sprintf('vgg-19final1/%s',cat);
    for j=3:num_scheme
        scheme=di1(j).name;
        mkdir(m11,scheme);
        mkdir(m21,scheme);
        mkdir(m31,scheme);
        mkdir(m41,scheme);
        mkdir(m13,scheme);
        mkdir(m23,scheme);
        mkdir(m33,scheme);
        mkdir(m43,scheme);
        u1=sprintf('./alexnet/%s/%s',cat,scheme);
        di2=dir(u1);
        num_context=length(di2);
        for k=3:num_context
            context=di2(k).name;
            m12=sprintf('alexnetfinal/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            m14=sprintf('alexnetfinal1/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            u12=sprintf('alexnet/%s/%s/%s',cat,scheme,context);
            m22=sprintf('googlenetfinal/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            m24=sprintf('googlenetfinal1/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            u22=sprintf('googlenet/%s/%s/%s',cat,scheme,context);
            m32=sprintf('ninfinal/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            m34=sprintf('ninfinal1/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            u32=sprintf('nin/%s/%s/%s',cat,scheme,context);
            m42=sprintf('vgg-19final/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4));
            m44=sprintf('vgg-19final1/%s/%s/%s.mat',cat,scheme,context(1:length(context)-4)); 
            u42=sprintf('vgg-19/%s/%s/%s',cat,scheme,context);            
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
            pk = result1{1,1};
            p=result1{1,2};
            p1=result2{1,2};
            p2=result3{1,2};
            p3=result4{1,2};
            lk(1)=length(p);
            lk(2)=length(p1);
            lk(3)=length(p2);
            lk(4)=length(p3);
            lkk=min(lk);
            l1=0;
            l2=0;
            l3=0;
            l4=0;
            h90=[];
            h91=[];
            h92=[];
            h93=[];
            j11(i)=0;
            for v1=1:k11:lkk-1
                start=v1;
                r1=[];
                r2=[];
                r3=[];
                r4=[];
                j11(i)=j11(i)+1;
                for v2=start:start+k11-1
                    %v2
                    r1(v2-start+1)=p{v2,1}-48;
                    r2(v2-start+1)=p1{v2,1}-48;
                    r3(v2-start+1)=p2{v2,1}-48;
                    r4(v2-start+1)=p3{v2,1}-48;
                end
                e1=0;
                e11=0;
                e2=0;
                e21=0;
                e3=0;
                e31=0;
                e4=0;
                e41=0;
                    s1 =0;
                    s=0;
                    for v2=1:k11
                        s1= s1+(r2(v2)*((k11-v2+1)));
                        s = s+(k11-v2+1);
                    end
                    s1 = s1/s;
                    l1 = l1+1;
                    h90(l1)=s1;
                    for v2=1:k11
                        if(r2(v2)==1 && e2==0)
                            e21=0;
                            pos=v2;
                            for v3=pos:k11
                                if(r2(v3)==0)
                                    e21=1;
                                end
                            end
                            if(e21==0)
                                e2=1;
                            else
                                e2=0;
                            end
                        end
                    end
                    if(pos==1)
                        pos=0;
                    end
                    l2=l2+1;
                    h91(l2)=(pos/k11);
                    for v2=1:k11
                        if(r3(v2)==1 && e3==0)
                            e31=0;
                            pos=v2;
                            for v3=pos:k11
                                if(r3(v3)==0)
                                    e31=1;
                                end
                            end
                            if(e31==0)
                                e3=1;
                            else
                                e3=0;
                            end
                        end
                    end
                    if(pos==1)
                        pos=0;
                    end
                    l3=l3+1;
                    h92(l3)=(pos/k11);
                    for v2=1:k11
                        if(r4(v2)==1 && e4==0)
                            e41=0;
                            pos=v2;
                            for v3=pos:k11
                                if(r4(v3)==0)
                                    e41=1;
                                end
                            end
                            if(e41==0)
                                e4=1;
                            else
                                e4=0;
                            end
                        end
                    end
                    if(pos==1)
                        pos=0;
                    end
                    l4=l4+1;
                    h93(l4)=(pos/k11);                    
                
            end
            save(m12,'h90','-v7.3');
            save(m22,'h91','-v7.3');
            save(m32,'h92','-v7.3');
            save(m42,'h93','-v7.3');
            save(m14,'l1','-v7.3');
            save(m24,'l2','-v7.3');
            save(m34,'l3','-v7.3');
            save(m44,'l4','-v7.3');            
        end
    end
end
end 