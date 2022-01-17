function coins_img = coins_cropping(image, centers, radii, DEBUG)
    if(~exist('DEBUG','var'))
        DEBUG = false;
    end
    L = length(radii);
    coins_img = cell(1,L);
    for i = 1:L
        xMin = floor(centers(i,1)-radii(i));
        if xMin < 0
            xMin = 0;
        end
        Length = ceil(2*radii(i));
        yMin = floor(centers(i,2)-radii(i));
        if yMin < 0
            yMin = 0;
        end
        im = imcrop(image,[xMin, yMin, Length, Length]);
        [M,N,O] = size(im);
        mask = create_circle_mask(max(M,N), radii(i));
        im(repmat(mask(1:M,1:N),[1,1,3])==0)=1;  
        coins_img(1,i) = mat2cell(im,M,N,O);
        if(DEBUG)
            figure
            imshow(im)
        end
    end
end