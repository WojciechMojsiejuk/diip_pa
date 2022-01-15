function mask = create_circle_mask(square_len, radius)
   if mod(square_len,2) == 1
       square_len = square_len + 1;
   end
   [xx,yy] = meshgrid(1:square_len,1:square_len);
   mask = false(square_len,square_len);
   mask = mask | hypot(xx - floor(0.5*square_len), yy - floor(0.5*square_len)) <= radius;
end