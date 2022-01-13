function [centers, radii]=coins_detection(img, minRadius, maxRadius, DEBUG)

    if ~exist('DEBUG','var')
        DEBUG = false;
    end

    I = rgb2gray(img);
    I = imcomplement(I);
    imshow(I)
    [Gmag, ~] = imgradient(I,'intermediate');
    se = strel('disk',30);
    BW = imclose(Gmag,se);
    h = fspecial('disk',20);
    BW = imfilter(BW,h,'replicate');
    BW = imgaussfilt(BW,10);
    BW = (BW>0.05);
    [centers, radii]=imfindcircles(BW, [minRadius,maxRadius],'Sensitivity',0.97);
    [centers, radii]=skip_repetition(centers, radii);
    if(DEBUG)
        figure
        imshowpair(I,BW,'montage'), hold on
        viscircles(centers, radii,'EdgeColor','b','LineWidth',1);
    end
end

function [centers, radii] = skip_repetition(centers, radii)
    L = length(radii);
    for i = 1:L-1
        for j = i+1:L
            if(norm(centers(i,:)-centers(j,:)) < radii(i))
                centers(j,:) = [];
                radii(j) = [];
                L = L-1;
                if(j >= L || i >= L)
                    break;
                end
            elseif(norm(centers(i,:)-centers(j,:)) < radii(j))
                centers(i,:) = [];
                radii(i) = [];
                L = L-1;
                if(j >= L || i >= L)
                    break;
                end
            end
                
        end
    end
            
    
end