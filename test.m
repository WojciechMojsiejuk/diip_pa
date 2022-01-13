close all
img = im2double(imread('measurement_2_1.JPG'));
cimg = image_cropping(img);
F_img = im2double(imread('F_mean.JPG'));
fimg = image_cropping(F_img);
[h,v]=geometry_calibration(fimg);
geometry_estim(cimg,h,v)
cii = coins_in_images;
flip(cii(7,:))