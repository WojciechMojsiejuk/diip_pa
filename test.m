close all
img = im2double(imread('measurement_1_1.JPG'));
cimg = image_cropping(img);
[h,v]=geometry_calibration(cimg);
geometry_estim(cimg,h,v);
