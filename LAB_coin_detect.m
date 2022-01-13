close all
clear all
clc
img = im2double(imread('measurement_1_1.JPG'));
limg = rgb2lab(img,'WhitePoint','d50');
figure
BW = limg(:,:,3);
% se = strel('disk',45);
% BW = imdilate(BW,se);
subplot(2,2,1)
imshow(BW,[min(BW(:)),max(BW(:))])
% BW = normalize(BW, '');
[BW, ~] = imgradient(BW,'prewitt');
subplot(2,2,2)
imshow(BW)
% subplot(2,2,3)
% h = fspecial('disk',10);
% BW = imfilter(BW,h,'replicate');
% BW = imgaussfilt(BW,5);
% % se = strel('disk',35);
% % BW = imopen(BW,se);
% % BW = imclose(BW,se);
% imshow(BW,[min(BW(:)),max(BW(:))])
% % maxV = max(BW(:))
% % minV = min(BW(:))
% % D = abs(maxV - minV)
% % BW = ((BW <= minV) | (BW > -0.6));
% % BW = imbinarize(BW);
% se = strel('disk',60);
% BW = imopen(BW,se);
% % BW = imopen(BW,se);
% subplot(2,2,4)
% imshow(BW,[min(BW(:)),max(BW(:))]), hold on
% [centers, radii]=imfindcircles(BW, [180,320],'Sensitivity',0.8)
% viscircles(centers, radii,'EdgeColor','b');