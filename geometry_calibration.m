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
           W = [W,box(3)];
           H = [H,box(4)];
       end
    end 
    
    W_mean = mean(W);
    H_mean = mean(H);
   
    h_px_2_mm = 12.5/W_mean;
    v_px_2_mm = 12.5/H_mean;
end