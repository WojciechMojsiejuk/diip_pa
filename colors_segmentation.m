function [uniqueRGBs,countRGB, RGB]= colors_segmentation(img, k, DEBUG) 
    if ~exist('DEBUG','var')
        DEBUG = false;
    end
    if ~exist('k','var')
        k = 3;
    end
    Iu = uint8(255 * img);%cropped coin image
    [L,C]=imsegkmeans(Iu,k);
    RGB = label2rgb(L,im2double(C));
    if(DEBUG)
        figure
        imshow(RGB)
    end
    redChannel = RGB(:, :, 1);
    greenChannel = RGB(:, :, 2);
    blueChannel = RGB(:, :, 3);
    data = double([redChannel(:), greenChannel(:), blueChannel(:)]);
    uniqueRGBs = unique(data,'rows');
    uniqueRGBs = remove_closest_to_white(uniqueRGBs);
    N = size(uniqueRGBs,1);
    M = size(data,1);
    countRGB = zeros(1,N);
    for i = 1:N
        for j = 1:M
            if data(j,:) == uniqueRGBs(i,:)
                countRGB(1,i) = countRGB(1,i) + 1;
            end
        end
    end
    countRGB=countRGB/sum(countRGB);
    uniqueRGBs = colors_min_max_scaling(uniqueRGBs);
end

function RGBs=remove_closest_to_white(RGBs)
    white = [255,255,255];
    closeness = zeros(1,size(RGBs,1));
    for i = 1:length(closeness)
        closeness(i) = norm(white(:) - RGBs(i,:));
    end
    [~, idx] = min(closeness);
    RGBs(idx,:) = [];
end

function RGBs = colors_min_max_scaling(RGBs)
    RGBs = RGBs./255;
end
