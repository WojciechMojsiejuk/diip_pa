function decision = is_circle(region, tol)
    decision = region.Circularity > tol;
end