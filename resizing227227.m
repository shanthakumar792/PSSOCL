function resizing227227
s=sprintf('./Annotation/*.mat');
D=dir(s);
p=zeros(13,1);
 str_parts_list_path = sprintf('shanthacatchange.txt');
 fid = fopen(str_parts_list_path,'r');
 parts=textscan(fid,'%s%s','delimiter',',');
 mkdir('maskchange');
for i=1:length(D)-8750
    name=D(i).name;
    p1=zeros(13,1);
    year=name(1:4);
    imname=name(1:length(name)-4);
    s1=sprintf('./Annotation/%s',name);
    load(s1);
    for j=1:length(sname_annot)
        cat=sname_annot(j).class;
        for l=1:13
            if(strcmp(cat,parts{1,2}{l,1}))
                c4=l;
                
            end
        end
        
        s2=sprintf('./Annotatedobjects/%s/%s-*.mat',cat,imname);
        D1=dir(s2);
      %  mkdir('maskchange',cat);
        if(p1(c4)==0)
        for k=1:length(D1)
            p1(c4)=1;
            objectname=D1(k,1).name;
            s3=sprintf('./Annotatedobjects/%s/%s',cat,objectname);
            s4=sprintf('./myoutput/%s/%s',cat,objectname);
            q1=load(s3);
            q=load(s4);
            m=q.sname_annot.mask;
            [h,w]=size(m);
           [rrv,ccv]=find(m);           
           left=min(ccv); right=max(ccv);
           up=min(rrv); down=max(rrv);
           objmask=m(up:down,left:right);
           mid_w=round((right+left)/2);
           mid_h=round((up+down)/2);
           width=right-left+1;
           height=down-up+1;
           percent=5;
           lnew=left;
           rnew=right;
           unew=up;
           dnew=down;
           k4=0;
           k1=1;
           k2=1;
           k3=1;
           while((k1==1 || (k2==1 || k3==1)) && k4==0)
           k1=0;
           k2=0;
           k3=0;
           wnew=round((width*(percent/100))+width);
           hnew=round((height*(percent/100))+height);
           percent=percent+3;
           wnew1=round(wnew/2);
           hnew1=round(hnew/2);
           if((mid_w-(wnew1)>=1)&&((mid_w+(wnew1))<=w)&&((mid_h-(hnew1))>=1)&&((mid_h+(hnew1))<=h))
               lnew=mid_w-wnew1;
               rnew=mid_w+wnew1;
               unew=mid_h-hnew1;
               dnew=mid_h+hnew1;
               k1=1;
           else
               if((mid_w-wnew1<1) &&((mid_w+wnew-(width/2))<=w))
                   lnew=lnew;
                   rnew=mid_w+wnew-(width/2);
                   k2=1;
               elseif((mid_w+(wnew1)>w)&&((mid_w-wnew+(width/2))>=1))
                   lnew=mid_w-wnew+(width/2);
                   rnew=rnew;
                   k2=1;
               end
               if((mid_h-(hnew1)<1)&&((mid_h+hnew-(height/2))<=h))
                   unew=unew;
                   dnew=mid_h+hnew-(height/2);
                   k3=1;
               elseif((mid_h+(hnew1)>h)&&(mid_h-hnew+(height/2))>=1)
                   unew=mid_h-hnew+(height/2);
                   dnew=dnew;
                   k3=1;
               end
           end
           dimension(3)=lnew;
           dimension(4)=rnew;
           dimension(1)=unew;
           dimension(2)=dnew;
           dimension1(1)=up;
           dimension1(2)=down;
           dimension1(3)=left;
           dimension1(4)=right;
           if(k1==1 || (k2==1 || k3==1))
           lnew=round(lnew);
           rnew=round(rnew);
           unew=round(unew);
           dnew=round(dnew);
           new_height=dnew-unew+1;
          new_width=rnew-lnew+1;
          if(new_height>new_width)
              ww=227;
              hh=round(ww*new_height/new_width);
          else
              hh=227;
              ww=round(hh*new_width/new_height);
          end
          mnew=m(unew:dnew,lnew:rnew);
          new_mask=imresize(mnew,[hh ww]);
          if(hh>ww)
              h_middle=round(hh/2);
              new_mask1=new_mask(h_middle-113:h_middle+113,1:227);
              unwanted1=new_mask(1:h_middle-114,1:227);
              unwanted2=new_mask(h_middle+114:hh,1:227);
          else
              w_middle=round(ww/2);
              new_mask1=new_mask(1:227,w_middle-113:w_middle+113);
              unwanted1=new_mask(1:227,1:w_middle-114);
              unwanted2=new_mask(1:227,w_middle+114:ww);
          end
          if(~(length(find(unwanted1)) || length(find(unwanted2))))
              k4=1;
              p(c4)=p(c4)+1;
         %     o3=sprintf('maskchange/%s/%s',cat,objectname);
         %     save(o3,'dimension','-v7.3');
          end
           end
           end
        end
        end
    end
end
p
end