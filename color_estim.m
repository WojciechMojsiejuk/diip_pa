function [C,dist, RGB] = color_estim(im, K, isDark, DEBUG)
    if ~exist('K','var')
        K = 7;
    end
    if ~exist('isDark','var')
        isDark=false;
    end
    if ~exist('DEBUG','var')
        DEBUG = false;
    end

    % im = apply_filter(im);
    im = illumination_normalization(im);
    % im = lin2rgb(im);
    im = imlocalbrighten(im);
    im = delete_background(im);


    %Reading model images
    model1 = im2double(imread('models/5_cold2.png'));
    model2 = im2double(imread('models/10_2.png'));
    model3 = im2double(imread('models/20_cold.png'));
    model4 = im2double(imread('models/50_2.png'));
    model5 = im2double(imread('models/1.png'));
    model6 = im2double(imread('models/2_4.png'));

    % Applying illuminant
    model1 = apply_illuminant(model1);
    model2 = apply_illuminant(model2);
    model3 = apply_illuminant(model3);
    model4 = apply_illuminant(model4);
    model5 = apply_illuminant(model5);
    model6 = apply_illuminant(model6);

    % Adding blur to the image
    im = blur_img(im);
    model1 = blur_img(model1);
    model2 = blur_img(model2);
    model3 = blur_img(model3);
    model4 = blur_img(model4);
    model5 = blur_img(model5);
    model6 = blur_img(model6);

    %K means color segmentation
    [rgb,  count,  RGB] =sorted_colors_segmentation(im, K);
    [rgb1, count1, RGB1]=sorted_colors_segmentation(model1, K);
    [rgb2, count2, RGB2]=sorted_colors_segmentation(model2, K);
    [rgb3, count3, RGB3]=sorted_colors_segmentation(model3, K);
    [rgb4, count4, RGB4]=sorted_colors_segmentation(model4, K);
    [rgb5, count5, RGB5]=sorted_colors_segmentation(model5, K);
    [rgb6, count6, RGB6]=sorted_colors_segmentation(model6, K);

    %Computing dist
    D1 = norm(count1'.*(rgb-rgb1));
    D2 = norm(count2'.*(rgb-rgb2));
    D3 = norm(count3'.*(rgb-rgb3));
    D4 = norm(count4'.*(rgb-rgb4));
    D5 = norm(count5'.*(rgb-rgb5));
    D6 = norm(count6'.*(rgb-rgb6));
    dist=[D1,D2,D3,D4,D5,D6];
    
    if(DEBUG)
        figure
        subplot(3,3,1:3)
        imshow(RGB)
        subplot(3,3,4)
        imshow(RGB1)
        subplot(3,3,5)
        imshow(RGB2)
        subplot(3,3,6)
        imshow(RGB3)
        subplot(3,3,7)
        imshow(RGB4)
        subplot(3,3,8)
        imshow(RGB5)
        subplot(3,3,9)
        imshow(RGB6)
    end  
    
    
    
    rgb(:,4) = count';
    rgb1(:,4) = count1';
    rgb2(:,4) = count2';
    rgb3(:,4) = count3';
    rgb4(:,4) = count4';
    rgb5(:,4) = count5';
    rgb6(:,4) = count6';
    
    C1 = count1'.*mvnpdf(rgb,rgb1);
    C2 = count2'.*mvnpdf(rgb,rgb2);
    C3 = count3'.*mvnpdf(rgb,rgb3);
    C4 = count4'.*mvnpdf(rgb,rgb4);
    C5 = count5'.*mvnpdf(rgb,rgb5);
    C6 = count6'.*mvnpdf(rgb,rgb6);
    C = [sum(C1), sum(C2), sum(C3), sum(C4), sum(C5), sum(C6)];
    
end


function [rgb, count, segmented_im] = sorted_colors_segmentation(im, K)
    [rgb, count, segmented_im]=colors_segmentation(im, K);
    [count, idx]=sort(count);
    rgb = rgb(idx,:);
end








% CREATING ILLUMINANT
% F = im2double(imread('F_mean.JPG'));
% background =  F(1:540,1:540,:);
% background = imgaussfilt(background,10);
% 
