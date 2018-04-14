function y1= contour_based_filter(i1,i2)
I = i1; % Read image
I = imresize(I,[40 60]); % For testing purpose ...
gI = rgb2gray(I); % Convert to grayscale
mask = i2; % Read mask

% Get contour mask
disk_radius = 1;
se = strel('disk',disk_radius);
mask2 = imdilate(mask,se);
contour_mask = mask2 - mask;
    
% Compute the distance transform on contour mask
dist_trans = bwdist(contour_mask,'euclidean');

% Normalize the distance transform so that maximum distance
% is 1
dist_trans = dist_trans / max(dist_trans(:));

% For each pixel in the image, define a gaussian kernel as a function
% of its (normalized) distance transform value and blur it using the kernel
I_filt = zeros(size(gI));
MIN_DIST_TRANS_VALUE = 1e-2; %TRY CHANGING THIS
DROPOFF_FACTOR = 1; % TRY CHANGING THIS
for row = 1:size(I,1)
    parfor col = 1:size(I,2)
        dist_trans_val = dist_trans(row,col);
        if( dist_trans_val <= MIN_DIST_TRANS_VALUE )  continue; end
        dist_trans_inv = double(1.0/(dist_trans_val^DROPOFF_FACTOR));
        dist_trans_inv = max(dist_trans_inv,1);
        h = fspecial('gaussian',[5 5],dist_trans_inv); % TRY CHANGING THIS (to gaussian)        
        r = int32((size(h,1)-1)/2);
        resp_val = 0;
        for m = -r:r
            for n = -r:r
                if( row+m >= 1 && row+m <= size(I,1) && col+n >= 1 && col+n <= size(I,2) )
                    resp_val = resp_val + h(m+r+1,n+r+1) * I(row+m,col+n);
                end
            end
        end
        I_filt(row,col) = uint8(resp_val);
    end
end
y1=I_filt;
subplot(1,2,1); imshow(gI);
subplot(1,2,2); imshow(double(I_filt)/255);
