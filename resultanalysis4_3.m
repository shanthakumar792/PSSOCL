% for contextual based analysis of the category epitomes
function resultanalysis4_3
context{1}='without_context.mat';
context{2}='with_context.mat';
context{3}='blurcontext1.mat';
context{4}='blurcontext2.mat';
for i=1:4
    back=context{i};
    d='./vgg-19';
    di=dir(d);
    num_cat=length(di)-2;
    q=1;
    for j=3:num_cat+2
     cat=di(j).name;
     u1=sprintf('./vgg-19/%s',cat);
     d1=dir(u1);
     num_scheme=length(d1);
     ki=1;
     
     scheme1='length';
     u3=sprintf('./vgg-19final1/%s/%s/%s',cat,scheme1,back);
     load(u3);
     sk(j-2)=l4;
      for k=3:num_scheme
          scheme=d1(k).name;
          if(~strcmp(scheme,'randomorder'))
           u2=sprintf('./vgg-19final/%s/%s/%s',cat,scheme,back);           
           load(u2);
           s1=h93;
           s2(q)=median(s1);
           s5(ki)=median(s1);
           ki=ki+1;
           q=q+1;
          end
      end
      s6(i,j-2)=median(s5);
      s7(i,j-2)=std(s5)/sqrt(length(s2));
    end
    uio=0;
    koj=0;
    for m2=1:length(sk)
        if(sk(m2)>0)
        uio=uio+(1*s6(i,m2));
        koj=koj+sk(m2);
        end
    end
    s3(i)=uio/12;
    s4(i)=std(s2)/sqrt(length(s2));
end
s3
s4
end