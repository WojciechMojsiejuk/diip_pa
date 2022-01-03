function geometry_estim(img, h_px_2_mm, v_px_2_mm)
    diameters =  coins_diameters();
    radii_px = (diameters*h_px_2_mm)./(2);
    [sorted_radii_px, idx] = sort(radii_px);
    
    difference = diff(sorted_radii_px);
    I = rgb2gray(img);
    BW = imbinarize(I);
    se = strel('disk',15);
    closeBW = imopen(BW,se);
    closeBW = imcomplement(closeBW);
    s = regionprops(closeBW,'Centroid','Circularity','MajorAxisLength','MinorAxisLength');
    figure
    imshow(closeBW), hold on
     for i = 1:length(s)
        plot(s(i).Centroid(1),s(i).Centroid(2),'b*')
        if is_circle(s(i), 0.9)
            viscircles(s(i).Centroid, s(i).MajorAxisLength/2,'EdgeColor','b');
        end
    end 
%      [centers, radii, metric] = imfindcircles(closeBW,[350,450]);
%      viscircles(centers, radii,'EdgeColor','b');
%     
%     for i = 1:length(sorted_radii_px)-1
%         [centers, radii, metric] = imfindcircles(I,[floor(sorted_radii_px(i)-difference(i)),ceil(sorted_radii_px(i)+difference(i))]);
%     end
%     
%     centersStrong5 = centers(1:5,:); 
%     radiiStrong5 = radii(1:5);
%     metricStrong5 = metric(1:5);
% 
%     imshow(img), hold on
%     viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
end