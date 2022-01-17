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
    model1 = im2double(imread('models/5_dim.png'));
    model2 = im2double(imread('models/10.png'));
    model3 = im2double(imread('models/20.png'));
    model4 = im2double(imread('models/50.png'));
    model5 = im2double(imread('models/1.png'));
    model6 = im2double(imread('models/2.png'));

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

    %Computing dist and MVNPDF
    dist=[norm(rgb-rgb1),norm(rgb-rgb2),norm(rgb-rgb3),norm(rgb-rgb4),norm(rgb-rgb5),norm(rgb-rgb6)];
    C = [sum(count1*mvnpdf(rgb,rgb1)),sum(count2*mvnpdf(rgb,rgb2)),sum(count3*mvnpdf(rgb,rgb3)),sum(count4*mvnpdf(rgb,rgb4)),sum(count5*mvnpdf(rgb,rgb5)),sum(count6*mvnpdf(rgb,rgb6))];
    
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
    
    function modified_model_img = apply_illuminant(model_img)
        if(isDark)
            illuminant = im2double(imread('SceneIlluminant.png'));
            modified_model_img =im2double(imfuse(model_img,illuminant,'blend','Scaling','joint'));
        else
            modified_model_img=model_img;
        end
        mask = create_circle_mask(540, 270);
        modified_model_img(repmat(mask,[1,1,3])==0)=1; 
        if(isDark)
            modified_model_img = illumination_normalization(modified_model_img);
%             modified_model_img = imlocalbrighten(modified_model_img);
        end
    end    
end



function [rgb, count, segmented_im] = sorted_colors_segmentation(im, K)
    [rgb, count, segmented_im]=colors_segmentation(im, K);
    [count, idx]=sort(count);
    rgb = rgb(idx,:);
end

function blurred = blur_img(img)
    H = fspecial('disk',10);
    blurred = imfilter(img,H,'replicate'); 
end

function dimg = apply_filter(img)
    illuminant = im2double(imread('SceneIlluminantLarge.png'));
    [M,N,~]=size(img);
    background = illuminant(1:M,1:N,:);
    dimg = img./(1.3*background);
end

function img = delete_background(img)
    [M,N,~]=size(img);
    L = max([M,N]);
    mask = create_circle_mask(L, L/2);
    img(repmat(mask(1:M,1:N,:),[1,1,3])==0)=1;  
end


% CREATING ILLUMINANT
% F = im2double(imread('F_mean.JPG'));
% background =  F(1:540,1:540,:);
% background = imgaussfilt(background,10);
% 
