close all
img = im2double(imread('measurement_1_1.JPG'));
img = illumination_normalization(img);
BW = rgb2gray(img);
h = fspecial('disk',30);
BW = imfilter(BW,h,'replicate');
BW = imgaussfilt(BW,10);
% BW = histeq(BW);

se = strel('disk',35);
closeBW = imopen(BW,se);
closeBW = imclose(closeBW,se);
cimg = imcomplement(closeBW);
bimg = ((cimg > 0.4) & (cimg < 0.9));
closeBW = imopen(bimg,se);
closeBW = imclose(closeBW,se);
figure
imshow(closeBW), hold on
[centers, radii]=imfindcircles(closeBW, [160,300],'Sensitivity',0.96)
viscircles(centers, radii,'EdgeColor','b');