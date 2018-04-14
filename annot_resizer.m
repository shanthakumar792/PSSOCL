function annot_resizer
anno_files = './Annotatedobjects/';
D=dir(anno_files);
for cat_id=1:13
    id=cat_id+2;
    catname=D(id).name;
    u=sprintf('./Annotatedobjects/%s',catname);
    D1=dir(u);
    sname_annot=[];
    for i=3:size(D1)
        matname=D1(i).name;
        name=matname(1:length(matname)-4);
        u1=sprintf('./Annotatedobjects/%s/%s',catname,matname);
        load(u1);
        obj=sname_annot1;
        [rrv,ccv]=find(obj.mask);
        minr=min(rrv);maxr=max(rrv);
        minc=min(ccv);maxc=max(ccv);
        sname_annot.class=sname_annot1.class;
        sname_annot.mask=sname_annot1.mask;
        for j=1:length(sname_annot1.toadd)
            sname_annot.toadd(j).parttobeadded=sname_annot1.toadd(j).parttobeadded;
        end
        if(~isempty(sname_annot1.parts))
         for j=1:length(sname_annot1.parts)
            sname_annot.parts(j).partname=sname_annot1.parts(j).partname;
            [h,w]=size(sname_annot1.parts(j));
            sname_annot.parts(j).mask=sname_annot1.parts(j).mask(minr:maxr,minc:maxc);
         end
        else
           sname_annot.parts=[];
        end
         u3=sprintf('myoutput/%s/%s',catname,name);
         save(u3,'sname_annot','-v7.3');
     sname_annot=[];
    end
   
end    
end