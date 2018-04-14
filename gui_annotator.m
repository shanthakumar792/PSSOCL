function gui_annotator(cat_id,start_id)

close all;

tmpcell = inputdlg('Enter your name (no whitespaces)');
user_name = char(tmpcell);
cat_dirs_path = './annotated-images/*.jpg';
D = dir(cat_dirs_path);
num_categories = length(D);
mkdir('myannot');
if( cat_id < 1 || cat_id > num_categories )
    fprintf('Please enter a category id between %d and %d\n',1,num_categories);
    return;
end

dir_id = cat_id;
catg_dir = D(dir_id).name;
catname=catg_dir(1:length(catg_dir)-14);
fprintf('Category: %s\n',catname);
u1=sprintf('annotated-images/%s-annotated.jpg',catname);
image1=imread(u1);
u1=sprintf('myoutput/%s',catname);
D=dir(u1);
l=0;
global sss;
global doe;
doe=0;
done=0;
remaining=length(D)-1-start_id;
S.usr=user_name;
S.cat=catname;
S.t2=image1;
Iid=start_id+2;
for i=Iid:length(D)
    remaining=remaining-1;
   S.fh = figure('units','normalized','OuterPosition',[0 0.05 1 0.9]);   
    subplot(1,3,3);imshow(image1);
    ann_name=D(i).name;
    imname=ann_name(1:length(ann_name)-4);
    u=sprintf('inputimages/%s/%s.png',catname,imname);
    image2=imread(u);
    subplot(1,3,3);imshow(image1);
    subplot(1,3,1);imshow(image2);
    S.name=imname;
    S.t3=image2;
S.pb = uicontrol('style','push',...
                 'unit','pix',...
                 'position',[10 10 100 20],...
                 'string','CLICK',...
                 'tooltip','Push to find out which radio button is selected');
S.rd(1) = uicontrol('style','rad',...
                    'unit','pix',...
                    'position',[10 40 100 20],...
                    'string','YES');
S.rd(2) = uicontrol('style','rad',...
                    'unit','pix',...
                    'position',[10 70 100 20],...
                    'string','NO');
                o11=sprintf('No. of done = %d',done);
                o12=sprintf('No. of remaining inputs = %d',remaining);
                o13=sprintf('Image number = %d',i-2);
menuitem_text_usrprompt = uicontrol('Style','text','String',{o11},'Units','normalized','Position',[0.8 0.05 0.15 0.05],'FontSize',9,'UserData','text_prompt_1');
menuitem_text_usrprompt = uicontrol('Style','text','String',{o12},'Units','normalized','Position',[0.8 0 0.15 0.05],'FontSize',9,'UserData','text_prompt_1');
menuitem_text_usrprompt = uicontrol('Style','text','String',{o13},'Units','normalized','Position',[0.8 0.1 0.15 0.05],'FontSize',9,'UserData','text_prompt_1');               
    p=[];
    ann_file=S.name;
    catn=S.cat;
    u=sprintf('myoutput/%s/%s',catn,ann_file);
    load(u);
    obj=sname_annot;
    S.qam=obj;
    subplot(1,3,3);imshow(S.t2);title('base image');
    subplot(1,3,1);imshow(S.t3);title('original');
    subplot(1,3,2);imshow(S.t3);title('to be done');
    
    part=obj.parts;
    toadd=obj.toadd;
    for j=1:length(toadd)
        p{j,1}=toadd(j).parttobeadded;
    end
    p{j+1,1}='UNDO';
    tmp_parts{1} = 'DONE';
    tmp_parts_2 = [tmp_parts ; p];
    x1 = tmp_parts_2;
    tmp_parts{1} = 'Select ..';
    tmp_parts_2 = [tmp_parts ; x1];
    x2 = tmp_parts_2;
    menuitem_popup_parts = uicontrol('Parent',S.fh,'Style','popup','String',x2,'Units','normalized','UserData','popup_parts');
     set(menuitem_popup_parts,'Position',[0.9 0.8 0.05 0.1]);
     S.m1=menuitem_popup_parts;
     hold on
     sss=ones(length(part),1);
     if ~isempty(part)
       for x=1:length(part)
        pn=part(x).partname;
        part_mask=part(x).mask;
         A=255.*part_mask;
        s=strel('disk',1,0);%Structuring element
        D1=~im2bw(A);%binary Image
        F=imerode(D1,s);
        s1=D1-F;
        [rrv,ccv]=find(s1);
        plot(ccv,rrv,'r.');
       end
     end
    hold off
set(S.pb,'callback',{@pb_call,S,ann_name});                
waitfor(S.pb,'Value');
if(doe==1)
    done=done+1;
end
sname_annot=[];
end

function [] = pb_call(varargin)
% Callback for pushbutton.
S = varargin{3};  % Get structure.
R = [get(S.rd(1),'val'), get(S.rd(2),'val')];  % Get state of radios.
global doe;
if R(1)==1 && R(2)==0
    disp('yes selected');
    annots_done=0;
    part_list_handles = [];
    part_list_names = [];
   while( ~annots_done ) 
    subplot(1,3,2); h = imfreehand(gca,'Closed','true');
        % Store annotation data
        h1 = findobj(h,'Type','line','Tag','top line');
        waitfor(S.m1,'Value');
       list=get(S.m1,'String');        
       str=list{get(S.m1,'Value')};
        if( strcmp(str,'UNDO') )
            delete(h);
        end
        if (strcmp(str,'DONE') )            
            annots_done = 1;
        end
        if( ~strcmp(str,'UNDO') && ~strcmp(str,'DONE') ) % Add current annotation info
            part_list_handles = [part_list_handles ; h1];
            part_list_names{end+1} =  str;
        end
    for j=1:length(part_list_handles)
                h_part = part_list_handles(j);
                rv=get(h_part,'XData');
                cv=get(h_part,'YData');
                subplot(1,3,2); hold on; plot(rv,cv,'g-');
    end
            subplot(1,3,2); hold off;
            set(S.m1,'Value',1);
   end
   lae=length(part_list_handles);
   m=zeros(lae,1);
   for j=1:lae
                h_part = part_list_handles(j);
                m(j)=2;
                str=part_list_names(j);
                rv=get(h_part,'XData');
                cv=get(h_part,'YData');
                subplot(1,3,2); hold on; plot(rv,cv,'g-');
                text(mean(rv),mean(cv), sprintf('%s',str{1,1}),'BackgroundColor',[1 1 .4]);
   end
            subplot(1,3,2); hold off;
            set(S.m1,'Value',1);
            w9=waitforbuttonpress;
            part_info=[];
    for j = 1:size(part_list_handles)
        h_part = part_list_handles(j);
        x_data = get(h_part,'XData');
        y_data = get(h_part,'YData');
        
        [h,w,o]=size(S.t3);
        mask1 = poly2mask(x_data,y_data,h,w);
       part_info(j).mask=mask1;
       part_info(j).name = char(part_list_names(j));
    end
    final=[];
    final.class=S.cat;
    v=0;
    for k=1:length(S.qam.parts)
        v=v+1;
        final.parts(v).partname=S.qam.parts(k).partname;
        final.parts(v).mask=S.qam.parts(k).mask;
    end
    if( ~isempty(part_info) )
      for k=1:length(part_info)
        v=v+1;
        final.parts(v).partname=part_info(k).name;
        final.parts(v).mask=part_info(k).mask;
      end
    end
    close
    global sss;
    lon=sss;
    indexes=[lon;m];
    final.index=indexes;
   u10=sprintf('myannot/%s_%s',S.cat,S.name);
   save(u10,'final','-v7.3');
   doe=1;
   pade=1;
elseif R(1)==0 && R(2)==1
    disp('no selected');
    doe=0;
    close
end