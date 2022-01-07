close all
img = im2double(imread('measurement_1_3.JPG'));
cimg = image_cropping(img);
[h,v]=geometry_calibration(cimg);
geometry_estim(cimg,h,v)
cii = coins_in_images;
flip(cii(1,:))