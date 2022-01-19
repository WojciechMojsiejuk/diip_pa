close all
clear all
clc
img = im2double(imread('measurement_1_1.JPG'));
cii = coins_in_images;
correct = flip(cii(1,:));
cimg = image_cropping(img);
cimg = illumination_normalization(cimg);
F_img = im2double(imread('F_mean.JPG'));
fimg = image_cropping(F_img);
[h,v]=geometry_calibration(fimg, false);
[coins, cimgs, C_geo]=geometry_estim(cimg,h,v);
NumberOfCoins = length(cimgs);
C_col = zeros(NumberOfCoins,6);
C_lab_and_hist = zeros(NumberOfCoins,6);
D = zeros(NumberOfCoins,6);

coins = zeros(1,6);

for i = 1:NumberOfCoins
    im=cell2mat(cimgs(i));
%     [C1,dist1, RGB1] = color_estim(im, 5, true, false);
%     [C2,dist2, RGB2] = color_estim(im, 7, true, false);
%     [C3,dist3, RGB3] = color_estim(im, 4, true, false);
%     C_col(i,:) = (C1+C2+C3)./3;
%     D(i,:) = (dist1+dist2+dist3)./3;
    
    [D_lab,C_lab] = lab_estim(im, 100);
    C_lab = normalize_pdf(C_lab);
    D_lab = normalize_pdf(D_lab);
    D_lab = 1 - D_lab;

    D_hist = hist_estim(im, 100);
    D_hist = normalize_pdf(D_hist);
    D_hist = 1-D_hist;

    C_lab_and_hist(i,:) = (C_lab + 0.3*D_lab + 0.3*D_hist)./(1.6);
end

C_geo = normalize_pdf(C_geo);
% C_col = normalize_pdf(C_col);

% D = normalize_pdf(D);
% D = 1 - D;
 
C_geo
C_lab_and_hist
C_tot = C_geo+0.9*C_lab_and_hist


[~,idx]=max(C_tot,[],2);
for i = 1:NumberOfCoins
    coins(idx(i)) = coins(idx(i)) + 1; 
end

coins
correct
figure
N = ceil(NumberOfCoins/2);
for i = 1:NumberOfCoins
    im=cell2mat(cimgs(i));
    subplot(N,2,i)
    imshow(im,[])
end