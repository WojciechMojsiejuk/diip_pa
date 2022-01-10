img = im2double(imread('measurement_2_1.JPG'));
cimg = illumination_normalization(img);
img2 = im2double(imread('measurement_2_2.JPG'));
cimg2 = illumination_normalization(img2);
img3 = im2double(imread('measurement_2_3.JPG'));
cimg3 = illumination_normalization(img3);


subplot(3,2,1)
imshow(img)
subplot(3,2,2)
imshow(cimg)
subplot(3,2,3)
imshow(img2)
subplot(3,2,4)
imshow(cimg2)
subplot(3,2,5)
imshow(img3)
subplot(3,2,6)
imshow(cimg3)