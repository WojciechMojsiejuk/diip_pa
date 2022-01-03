function [h_px_2_mm, v_px_2_mm]=geometry_calibration(image)
    I = rgb2gray(image);
    BW = imbinarize(I);
    se = strel('disk',20);
    closeBW = imopen(BW,se);
    s = regionprops(closeBW,'basic');
    figure, imshow(closeBW); hold on;
    W = [];
    H = [];
    for i = 1:length(s)
       rectangle('position',s(i).BoundingBox,'edgecolor','r','linewidth',2)
       if is_square(s(i), 20)
           rectangle('position',s(i).BoundingBox,'edgecolor','g','linewidth',4)
           box=s(i).BoundingBox;
           cimg = imcrop(I,box);
           W = [W,size(cimg,2)];
           H = [H,size(cimg,1)];
       end
    end 
    
    W_mean = mean(W);
    H_mean = mean(H);
   
    h_px_2_mm = W_mean/12.5;
    v_px_2_mm = H_mean/12.5;
end