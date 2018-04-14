% for part-importance based analysis of category epitomes.
function resultanalysis5_2
context{1}='length';
context{2}='randomorder';
context{3}='saliencytype1';
context{4}='saliencytype2';
context{5}='saliency_area_normalized_partseq_unweighted';
context{6}='saliency_area_normalized_partseq_weighted';
for i=1:6
    back=context{i};
    d='./nin';
    di=dir(d);
    num_cat=length(di)-2;
    q=1;
    for j=3:num_cat+2
     cat=di(j).name;
     u1=sprintf('./nin/%s/%s',cat,back);
     d1=dir(u1);
     num_scheme=length(d1);
     u3=sprintf('./ninfinal1/%s/%s/%s',cat,context{1},'blurcontext2');
     load(u3);
     sk(j-2)=l3;
     ki=1;
      for k=3:num_scheme
          scheme=d1(k).name;
           u2=sprintf('./ninfinal/%s/%s/%s.mat',cat,back,scheme(1:length(scheme)-4));
           load(u2);
           s1=h92;
           s2(q)=median(s1);
           s5(ki)=median(s1);
           ki=ki+1;
           q=q+1;
      end
      s6(i,j-2)=median(s5);
      s7(i,j-2)=std(s5)/sqrt(length(s2));
    end
    uio=0;
    koj=0;
    for m2=1:length(sk)
        if(sk(m2)>0)
        uio=uio+(sk(m2)*s6(i,m2));
        koj=koj+sk(m2);
        end
    end
    s3(i)=uio/koj;
     s4(i)=std(s2)/sqrt(length(s2));
end
s3
s4
end