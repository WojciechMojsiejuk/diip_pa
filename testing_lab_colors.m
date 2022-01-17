model1 = im2double(imread('models/5.png'));
model2 = im2double(imread('models/10.png'));
model3 = im2double(imread('models/20.png'));
model4 = im2double(imread('models/50.png'));
model5 = im2double(imread('models/1.png'));
model6 = im2double(imread('models/2.png'));
im = im2double(imread('coin_2.png'));


im = lin2rgb(model1);
imshow(im)
% limg = rgb2lab(model6,'WhitePoint','d50');
% B = limg(:,:,3);
% imshow(B,[-100,100])

% imshowpair(model1,im, 'montage')