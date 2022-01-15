clc
close all
cimg = cell2mat(cimgs(1)); %cropped coin image
figure
imshow(cimg)
model = im2double(imread('models/5.jpg'));
model2 = im2double(imread('models/10.jpg'));
model3 = im2double(imread('models/20.jpg'));
model4 = im2double(imread('models/50.jpg'));
model5 = im2double(imread('models/1.jpg'));
model6 = im2double(imread('models/2.jpg'));


[M,N,~] = size(cimg);
model = imresize(model,[M,N]);
model2 = imresize(model2,[M,N]);
model3 = imresize(model3,[M,N]);
model4 = imresize(model4,[M,N]);
model5 = imresize(model5,[M,N]);
model6 = imresize(model6,[M,N]);

I = rgb2gray(cimg);
Im1 = rgb2gray(model);
Im2 = rgb2gray(model2);
Im3 = rgb2gray(model3);
Im4 = rgb2gray(model4);
Im5 = rgb2gray(model5);
Im6 = rgb2gray(model6);

figure
subplot(4,2,1:2)
imshow(I,[]);
subplot(4,2,3)
imshow(Im1,[])
subplot(4,2,4)
imshow(Im2,[])
subplot(4,2,5)
imshow(Im3,[])
subplot(4,2,6)
imshow(Im4,[])
subplot(4,2,7)
imshow(Im5,[])
subplot(4,2,8)
imshow(Im6,[])

%% normxcorr

c = normxcorr2(Im1,I);
c2 = normxcorr2(Im2,I);
c3 = normxcorr2(Im3,I);
c4 = normxcorr2(Im4,I);
c5 = normxcorr2(Im5,I);
c6 = normxcorr2(Im6,I);


figure
subplot(3,2,1)
surf(c)
shading flat
subplot(3,2,2)
surf(c2)
shading flat
subplot(3,2,3)
surf(c3)
shading flat
subplot(3,2,4)
surf(c4)
shading flat
subplot(3,2,5)
surf(c5)
shading flat
subplot(3,2,6)
surf(c6)
shading flat

%% Fourier domain

C1 = log(real(ifft2(fft2(I) .* fft2(rot90(Im1,2),M,N))));
C2 = log(real(ifft2(fft2(I) .* fft2(rot90(Im2,2),M,N))));
C3 = log(real(ifft2(fft2(I) .* fft2(rot90(Im3,2),M,N))));
C4 = log(real(ifft2(fft2(I) .* fft2(rot90(Im4,2),M,N))));
C5 = log(real(ifft2(fft2(I) .* fft2(rot90(Im5,2),M,N))));
C6 = log(real(ifft2(fft2(I) .* fft2(rot90(Im6,2),M,N))));



figure
subplot(3,2,1)
imshow(C1,[])
subplot(3,2,2)
imshow(C2,[])
subplot(3,2,3)
imshow(C3,[])
subplot(3,2,4)
imshow(C4,[])
subplot(3,2,5)
imshow(C5,[])
subplot(3,2,6)
imshow(C6,[])

% 
% S=[sum(C1(:)),sum(C2(:)),sum(C3(:)),sum(C4(:)),sum(C5(:)),sum(C6(:))]
% [mS,midx]=max(S)
% 


% 
% %% calculate padding
% background = I;
% template = Im1;
% bx = size(background, 2); 
% by = size(background, 1);
% tx = size(template, 2); % used for bbox placement
% ty = size(template, 1);
% 
% %% fft
% %c = real(ifft2(fft2(background) .* fft2(template, by, bx)));
% 
% %// Change - Compute the cross power spectrum
% Ga = fft2(background);
% Gb = fft2(template, by, bx);
% c = real(ifft2((Ga.*conj(Gb))./abs(Ga.*conj(Gb))));
% 
% %% find peak correlation
% [max_c, imax]   = max(abs(c(:)));
% [ypeak, xpeak] = find(c == max(c(:)));
% figure; surf(c), shading flat; % plot correlation    
% 
% %% display best match
% hFig = figure;
% hAx  = axes;
% 
% %// New - no need to offset the coordinates anymore
% %// xpeak and ypeak are already the top left corner of the matched window
% position = [xpeak(1), ypeak(1), tx, ty];
% imshow(background, 'Parent', hAx);
% imrect(hAx, position);
