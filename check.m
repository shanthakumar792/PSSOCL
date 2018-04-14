% to take the annotations obtained from the users after annotating and make
% sure that it is compatible for the future process by storing it in a
% slightly different name.
function check
cat_dirs_path = './airplane/*.mat';
D = dir(cat_dirs_path);
num_categories = length(D);
class='airplane';
for i=1:num_categories
    nam=D(i).name;
    u=sprintf('airplane/%s',nam);
    lcat=length(class);
    anam=nam(lcat+2:length(nam));
    u1=sprintf('myoutput/%s/%s',class,anam);
    load(u1);
    load(u);
    s=[];
    s.cat=class;
    s.mask=sname_annot.mask;
    for j=1:length(final.parts)
        s.parts(1,j)=final.parts(1,j);
        s.index(1,j)=final.index(j,1);
    end
      u3=sprintf('myoutput1/%s/%s',class,anam);
      save(u3,'s','-v7.3');
    l=0;
end
end