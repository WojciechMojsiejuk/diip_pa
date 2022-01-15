function [coins,cropped_coins_imgs, C] = geometry_estim(img, h_px_2_mm, v_px_2_mm)
    diameters =  coins_diameters();
    coins = zeros(1,length(diameters));
    radii_px = (diameters*h_px_2_mm)./(2);
    [sorted_radii_px, ~] = sort(radii_px);
    difference = zeros(1,length(diameters)+1); 
    difference(2:end-1)=diff(sorted_radii_px);
    difference(1) = difference(2);
    difference(end) = difference(end-1);
    
    min_bound = floor(sorted_radii_px(1)-(difference(1)/2));
    max_bound = ceil(sorted_radii_px(end)+(difference(end)/1.2));
    
    [centers, radii] = coins_detection(img, min_bound, max_bound, true);
    
    cropped_coins_imgs = coins_cropping(img, centers, radii);
    
    C = zeros(length(radii),6);
    
    for idx = 1:length(radii)
        for coin = 1:6
            C(idx,coin) = log(normpdf(radii(idx),radii_px(coin)));
        end
    end
    [~, coins_idx] = max(C,[],2);
    for j = 1:length(coins_idx)
        coins(coins_idx(j)) = coins(coins_idx(j)) + 1;
    end
end