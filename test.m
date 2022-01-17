close all
clear all
clc
img = im2double(imread('measurement_1_3.JPG'));
cimg = image_cropping(img);
cimg = illumination_normalization(cimg);
F_img = im2double(imread('F_mean.JPG'));
fimg = image_cropping(F_img);
[h,v]=geometry_calibration(fimg, false);
[coins, cimgs, C_geo]=geometry_estim(cimg,h,v);
NumberOfCoins = length(cimgs);
C_col = zeros(NumberOfCoins,6);
D = zeros(NumberOfCoins,6);
for i = 1:NumberOfCoins
    im=cell2mat(cimgs(i));
    [C1,dist1, RGB] = color_estim(im, 7, true, false);
    [C2,dist2, RGB] = color_estim(im, 5, true, false);
    [C3,dist3, RGB] = color_estim(im, 3, true, false);
    C_col(i,:) = (C1+C2+C3)./3;
    D(i,:) = (dist1+dist2+dist3)./3;
end
C_geo = normalize_pdf(C_geo);
C_col = normalize_pdf(C_col);
D = normalize_pdf(D);
D = 1 - D;
C_tot = C_geo+C_col+D;

C_geo
C_col
D
C_tot
% cii = coins_in_images;
% % flip(cii(6,:))
% dist = normalize_pdf(dist);
% dist = 1 - dist; %we value the most objects with the smallest distance
% C = normalize_pdf(C);
    