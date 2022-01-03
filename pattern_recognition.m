%    
%    max_box = s(s.Area == max(s.Area)).BoundingBox
%    ROI = I(max_box(2):max_box(2)+max_box(4)-1,max_box(1):max_box(1)+max_box(3)-1);
%    figure
%    imshow(ROI)
  
    
%     model = (checkerboard(100) > 0.5);
%     figure
%     subplot(1,2,1)
%     imshow(BW)
%     subplot(1,2,2)
%     imshow(model)
%     c = normxcorr2(model,BW);
%     [max_c, imax] = max(abs(c(:)));
%     [ypeak, xpeak] = ind2sub(size(c),imax(1));
%     corr_offset = [(xpeak-size(model,2)) (ypeak-size(model,1))];
%     figure, imshow(I); hold on;
%     rectangle('position',[corr_offset(1) corr_offset(2) 50 50],...
%           'curvature',[1,1],'edgecolor','g','linewidth',2);
