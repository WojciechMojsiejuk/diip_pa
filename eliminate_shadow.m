function radius = eliminate_shadow(im, old_radius, minRadius, maxRadius)
maxBound = [217,217,217]./255;
minBound = [120, 115, 95]./255;

img = im;
idx = im(:,:,1) >= minBound(1) & im(:,:,1) <= maxBound(1) & im(:,:,2) >= minBound(2) & im(:,:,2) <= maxBound(2) & im(:,:,3) >= minBound(3) & im(:,:,3) <= maxBound(3);
% se = strel('disk',10);
% I = imclose(idx,se);
im(repmat(idx,[1,1,3])==1)=1;
BW = rgb2gray(im);
I = blur_img(BW);
I = imcomplement(I);
se = strel('disk',30);
I = imclose(I,se);
I = imopen(I,se);

[centers, radii]=imfindcircles(I, [minRadius,maxRadius],'Sensitivity',0.955);
diff_size = radii-old_radius;
if(length(diff_size)>1)
    if radii>=minRadius & radii<= maxRadius
        [~,closest_radii_idx]=min(abs(diff_size));
        radius=radii(closest_radii_idx);
    else
        error('Found wrong radius')
    end
    
elseif(length(diff_size) == 1)
    if radii>=minRadius & radii<= maxRadius
        radius=(4*old_radius+radii)./5;
        closest_radii_idx = 1;
    else
        error('Found wrong radius')
    end
else
    error('No radius found')
end

% 
% figure
% imshowpair(BW,I,'montage'), hold on
% viscircles(centers, radii,'EdgeColor','b','LineWidth',1);
% viscircles(centers(closest_radii_idx,:), radius,'EdgeColor','r','LineWidth',2);
% hold off

% I = imbinarize(I);
% stats = regionprops(I,'Centroid',...
%     'MajorAxisLength','Area');
% majorAxes = cat(1,stats.MajorAxisLength);
% majorAxes(majorAxes>= 2*minRadius & majorAxes<= 2*maxRadius);
% radius = max(majorAxes)/2;
% centroids = cat(1,stats.Centroid);
% areas = cat(1,stats.Area);
% [~,max_area_idx] = max(areas);
% centroid = centroids(max_area_idx,:);
% radius = (radius + old_radius)./2;
% figure
% imshowpair(img,I,'montage'), hold on
% viscircles(centroid, radius,'EdgeColor','r','LineWidth',1), hold off