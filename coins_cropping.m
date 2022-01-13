function coins_img = coins_cropping(image, centers, radii)
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
        mask = createCircle(max(M,N), radii(i));
        im(repmat(mask(1:M,1:N),[1,1,3])==0)=1;  
        coins_img(1,i) = mat2cell(im,M,N,O);
        figure
        imshow(im)
    end
end

function mask = createCircle(square_len, radius)
   if mod(square_len,2) == 1
       square_len = square_len + 1;
   end
   [xx,yy] = meshgrid(1:square_len,1:square_len);
   mask = false(square_len,square_len);
   mask = mask | hypot(xx - floor(0.5*square_len), yy - floor(0.5*square_len)) <= radius;
end