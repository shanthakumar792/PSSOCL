% to find the category epitomes in the obtained result data from the
% classifier and to store them. make sure before running the program to change the names of
% categories from already existing to the new one given in the partnames
% folder.
function resultalaysis1_2
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
    scheme='saliencytype2';
        context='blurcontext2.txt';
            m14=sprintf('alexnetfinal2/%s.mat',cat);
            u12=sprintf('alexnet/%s/%s/%s',cat,scheme,context);
            m24=sprintf('googlenetfinal2/%s.mat',cat);
            u22=sprintf('googlenet/%s/%s/%s',cat,scheme,context);
            m34=sprintf('ninfinal2/%s.mat',cat);
            u32=sprintf('nin/%s/%s/%s',cat,scheme,context);
            m44=sprintf('vgg-19final2/%s.mat',cat); 
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
            p=result1{1,2};
            p1=result2{1,2};
            p2=result3{1,2};
            p3=result4{1,2};
            lk(1)=length(p);
            lk(2)=length(p1);
            lk(3)=length(p2);
            lk(4)=length(p3);
            lkk=min(lk);
            e1=[];
            e2=[];
            e3=[];
            e4=[];
            h90=0;
            j11(i)=0;
            for v1=1:k11:lkk-1
                h90=h90+1;
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
                if(r1(k11)~=0)
                    e1=[e1,h90];
                end
                if(r2(k11)~=0)
                    e2=[e2,h90];
                end
                if(r3(k11)~=0)
                    e3=[e3,h90];
                end
                if(r4(k11)~=0)
                    e4=[e4,h90];
                end
            end
            save(m14,'e1','-v7.3');
            save(m24,'e2','-v7.3');
            save(m34,'e3','-v7.3');
            save(m44,'e4','-v7.3');
end