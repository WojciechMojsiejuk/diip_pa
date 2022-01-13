function [h_px_2_mm, v_px_2_mm]=geometry_calibration(image, DEBUG)
    
    if ~exist('DEBUG','var')
        DEBUG = false;
    end
    
    I = rgb2gray(image);
    BW = imbinarize(I);
    se = strel('disk',20);
    closeBW = imopen(BW,se);
    s = regionprops(closeBW,'basic');
    
    if(DEBUG)
        figure, imshow(closeBW); hold on;
    end
    W = [];
    H = [];
    for i = 1:length(s)
       if(DEBUG)
           rectangle('position',s(i).BoundingBox,'edgecolor','r','linewidth',2)
       end
       if is_square(s(i), 20)
           if(DEBUG)
               rectangle('position',s(i).BoundingBox,'edgecolor','g','linewidth',4)
           end
           box=s(i).BoundingBox;
           W = [W,box(3)];
           H = [H,box(4)];
       end
    end 

    W_mean = mean(W);
    H_mean = mean(H);
   
    h_px_2_mm = W_mean/12.5;
    v_px_2_mm = H_mean/12.5;
end