function [chi_sqr_dist, C_lab] = lab_estim(im, N, DEBUG)
    if ~exist('DEBUG','var')
        DEBUG = false;
    end
    if ~exist('N','var')
        N = 256;
    end

    %Reading model images
    model1 = im2double(imread('models/5.png'));
    model2 = im2double(imread('models/10.png'));
    model3 = im2double(imread('models/20.png'));
    model4 = im2double(imread('models/50.png'));
    model5 = im2double(imread('models/1.png'));
    model6 = im2double(imread('models/2.png'));
    
    
    im = illumination_normalization(im);
%     im = lin2rgb(im);
    im = imlocalbrighten(im);
    im = delete_background(im);
    [M,N,~] = size(model1);
    im = imresize(im, [M,N]);
    
     % Applying illuminant
%     im = apply_illuminant(im);
    model1 = apply_illuminant(model1);
    model2 = apply_illuminant(model2);
    model3 = apply_illuminant(model3);
    model4 = apply_illuminant(model4);
    model5 = apply_illuminant(model5);
    model6 = apply_illuminant(model6);
    
    % Convert to LAB
    im = rgb2lab(im,'WhitePoint','d50');
    im = im(:,:,3);
    im = delete_background(im, true);
    
    
    model1 = rgb2lab(model1,'WhitePoint','d50');
    model1 = model1(:,:,3);
    
    model2 = rgb2lab(model2,'WhitePoint','d50');
    model2 = model2(:,:,3);
    
    model3 = rgb2lab(model3,'WhitePoint','d50');
    model3 = model3(:,:,3);
    
    model4 = rgb2lab(model4,'WhitePoint','d50');
    model4 = model4(:,:,3);
    
    model5 = rgb2lab(model5,'WhitePoint','d50');
    model5 = model5(:,:,3);
    
    model6 = rgb2lab(model6,'WhitePoint','d50');
    model6 = model6(:,:,3);
    
    % Adding blur to the image
    im = blur_img(im,3);
    model1 = blur_img(model1,3);
    model2 = blur_img(model2,3);
    model3 = blur_img(model3,3);
    model4 = blur_img(model4,3);
    model5 = blur_img(model5,3);
    model6 = blur_img(model6,3);
    
    [counts, binLoc] = imhist(im,N);
    [counts1, binLoc1] = imhist(model1,N);
    [counts2, binLoc2] = imhist(model2,N);
    [counts3, binLoc3] = imhist(model3,N);
    [counts4, binLoc4] = imhist(model4,N);
    [counts5, binLoc5] = imhist(model5,N);
    [counts6, binLoc6] = imhist(model6,N);
    
    if(DEBUG)
        figure
        semilogy(binLoc,counts),hold on
        semilogy(binLoc1,counts1)
        semilogy(binLoc2,counts2)
        semilogy(binLoc3,counts3)
        semilogy(binLoc4,counts4)
        semilogy(binLoc5,counts5)
        semilogy(binLoc6,counts6), hold off
        legend('im','m1','m2','m3','m4','m5','m6')
    end
    
    D1 = pdist2(counts', counts1', 'chisq');
    D2 = pdist2(counts', counts2', 'chisq');
    D3 = pdist2(counts', counts3', 'chisq');
    D4 = pdist2(counts', counts4', 'chisq');
    D5 = pdist2(counts', counts5', 'chisq');
    D6 = pdist2(counts', counts6', 'chisq');
    chi_sqr_dist = [D1, D2, D3, D4, D5, D6];
    
    
    % Images must be normalized to the same range
    im = normalize(im, 'range',[0,1]);
    model1 = normalize(model1, 'range',[0,1]);
    model2 = normalize(model2, 'range',[0,1]);
    model3 = normalize(model3, 'range',[0,1]);
    model4 = normalize(model4, 'range',[0,1]);
    model5 = normalize(model5, 'range',[0,1]);
    model6 = normalize(model6, 'range',[0,1]);
    
    C1 = sum(normpdf(im(:),model1(:)));
    C2 = sum(normpdf(im(:),model2(:)));
    C3 = sum(normpdf(im(:),model3(:)));
    C4 = sum(normpdf(im(:),model4(:)));
    C5 = sum(normpdf(im(:),model5(:)));
    C6 = sum(normpdf(im(:),model6(:)));
    
    C_lab = [C1, C2, C3, C4, C5, C6];
    
    if(DEBUG)
        figure
        subplot(3,3,1:3)
        imshow(im,[])
        subplot(3,3,4)
        imshow(model1,[])
        subplot(3,3,5)
        imshow(model2,[])
        subplot(3,3,6)
        imshow(model3,[])
        subplot(3,3,7)
        imshow(model4,[])
        subplot(3,3,8)
        imshow(model5,[])
        subplot(3,3,9)
        imshow(model6,[])
    end
end