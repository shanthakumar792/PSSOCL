% takes in the bdry data structure from alphavol
% to find if the region is connected 
% returns 1 if connected '0' otherwise
% Arg1 - Alphashape data structure(the second arguement returned by alphavol) 
% Arg2 - Total number of datapoints involved

function [r] = isconnected(b,len)
    
    k = 1:len;
    k = reshape(k,size(k,1)*size(k,2),1);
    up = 0;
    s3 = [];

    for j1 = 1:size(b.tri,1)

        s_up = min(k(b.tri(j1,:),1));

        for j2 = 1:size(b.tri,2)
           k(b.tri(j1,j2),1) = s_up;
        end

    end

    for i = 1:size(k,1)
        k(i,1) = k(k(i,1),1);
    end

    if(sum(k)==size(k,1))
        r=1;
    else
        r=0;
    end
    
end