function blurred = blur_img(img, DiskSize)
    if ~exist('DiskSize','var')
        DiskSize = 10;
    end
    H = fspecial('disk',DiskSize);
    blurred = imfilter(img,H,'replicate'); 
end