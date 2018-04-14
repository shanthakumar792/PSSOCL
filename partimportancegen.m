function partimportancegen
di='./imagessaliency/*.jpg';
d=dir(di);
num_images=length(d);
di='./Annotation/*.mat';
d1=dir(di);
num_annot=length(d1);
type='length';
 for j=1:13
        p(j).occ2=0;
 end
 p(1).name='airplane';p(2).name='bicycle';
    p(3).name='bus';p(4).name='car (sedan)';
    p(5).name='cat';p(6).name='cow';
    p(7).name='dog';p(8).name='flying bird';
    p(9).name='horse';p(10).name='person walking';
    p(11).name='potted plant'; p(12).name='sheep';
    p(13).name='train';
    for i=1:13
        cat=p(i).name;
        u2=sprintf('./order/%s/%s.txt',cat,type);
        fid=fopen(u2,'r');
        partorder=textscan(fid,'%s','delimiter','\n');
        fclose(fid);
        partlength=length(partorder{1,1});
        p(i).occ1=zeros(partlength,1);
    end
 load('./pascalFix.mat');
 load('./pascalSize.mat');
for i=1:num_images
    imname=d(i).name;
    for j=1:13
        p(j).occ=0;
    end
    i
    fixation_image=fixCell{i,1};
    subjects=max(fixation_image(:,3));
    imname1=imname(1:length(imname)-4);
    for j=1:num_annot
        ann_name=d1(j).name;
        ann_name1=ann_name(1:length(ann_name)-4);
        if(strcmp(ann_name1,imname1))
            annot=ann_name;
            break;
        end
    end
    di1=sprintf('./Annotation/%s',annot);
    load(di1);
    for j=1:length(sname_annot)
        cat=sname_annot(j).class;
        for k=1:13
            if(strcmp(p(k).name,cat))
                p(k).occ=p(k).occ+1;
                break;
            end
        end
        di2=sprintf('./myoutput1/%s/%s-*.mat',cat,annot(1:length(annot)-4));
        d3=dir(di2);
        u2=sprintf('./order/%s/%s.txt',cat,type);
        fid=fopen(u2,'r');
        partorder=textscan(fid,'%s','delimiter','\n');
        fclose(fid);
        if((~isempty(d3))&&p(k).occ==1)
            for m=1:length(d3)
                p(k).occ2=p(k).occ2+1;
                di3=sprintf('./myoutput1/%s/%s',cat,d3(m).name);
                load(di3);
                objmask=s.mask;
                [rrv,ccv]=find(objmask);
                up=min(rrv);
                left=min(ccv);
                [h,w]=size(s.parts(1).mask);
                for n1=1:length(partorder{1,1})
                    partreq=partorder{1,1}{n1,1};
                    pmask=zeros(size(s.parts(1).mask));
                    for n2=1:length(s.parts)
                        if(strcmp(partreq,s.parts(n2).partname))
                            pmask=pmask+s.parts(n2).mask;
                        end
                    end                    
                    pmasknew=zeros(size(objmask));
                    for n2=1:h
                        for n3=1:w
                            pmasknew(up+n2,left+n3)=pmask(n2,n3);
                        end
                    end
                    [rrv1,ccv1]=find(pmasknew);
                    for n3=1:subjects
                        s8=find(fixation_image(:,3)==n3);
                        s9=length(s8);
                        q9=0;
                        for n10=1:s9
                           index=s8(n10);
                           
                        x_fix=fixation_image(index,1);
                        y_fix=fixation_image(index,2);
                    for n2=1:length(rrv1)
                        if(rrv1(n2)==x_fix && ccv1(n2)==y_fix)
                            q9=q9+1;
                           % p(k).occ1(n1)=p(k).occ1(n1)+((s9-((n10-1)/s9))/q9) ;
                        end
                        
                    end
                        end
                        p(k).occ1(n1)=p(k).occ1(n1)+(q9/s9) ; 
                    end
                end
              
            end
        end
    end
end
end