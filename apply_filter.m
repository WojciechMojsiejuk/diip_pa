function dimg = apply_filter(img)
    illuminant = im2double(imread('SceneIlluminantLarge.png'));
    [M,N,~]=size(img);
    background = illuminant(1:M,1:N,:);
    dimg = img./(1.3*background);
end