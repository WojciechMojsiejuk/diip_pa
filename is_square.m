function decision = is_square(region, etol)
    box = region.BoundingBox;
    
    ax1 = box(3);
    ax2 = box(4);
    
    area = region.Area;
    if abs(ax1-ax2) < etol
        decision = true;
    else
        decision = false;
    end
end