function decision = is_circle(region, tol)
    decision = (region.Circularity > tol) && (region.Circularity <= 1) ;
end