% Computes a compact alphashape
% the resulting region is connected
% Arg1 - datapoints
% Arg2 - display figure flag %% optional . 0 - figure off, 1 - figure on
% returns area, shape structure, radius

function [a,b,r] = compactalpha(data_cat,varargin)

fig = 0;

if(nargin>1)
    fig = varargin{1};
end
    r1= 10;
    r2= 10;
    [a,b] = alphavol(data_cat,r1,0);
    con1 = isconnected(b,size(data_cat,1));
    con2=con1;
    
    while(con2==con1 && r2~= inf)
        
        [a,b] = alphavol(data_cat,r2,0);
        con2 = isconnected(b,size(data_cat,1));
        if(con1==0)
            r2=r2*2;
        else
            r2=r2/2;
        end
    end
        
    if(r2==inf)
        r=r2;
    else
        while(abs(r1-r2)>1e-4)

            r = (r1+r2)/2;
            [a,b] = alphavol(data_cat,r,0);
            con3 = isconnected(b,size(data_cat,1));

            if(con3==con1)
                r1=r;
            else
                r2=r;
            end

        end
    
        if(con1==1)
            r=r1;
        else
            r=r2;
        end
    end
 
    [a,b] = alphavol(data_cat,r,fig);
    
end