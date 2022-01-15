close all
img = im2double(imread('measurement_1_1.JPG'));
cimg = image_cropping(img);
cimg = illumination_normalization(cimg);
F_img = im2double(imread('F_mean.JPG'));
fimg = image_cropping(F_img);
[h,v]=geometry_calibration(fimg, false);
[coins, cimgs, C]=geometry_estim(cimg,h,v);
C = normalize_pdf(C);
% cii = coins_in_images;
% flip(cii(6,:))