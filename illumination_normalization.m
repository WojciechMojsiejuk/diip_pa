function normalized_image = illumination_normalization(image, ~)
    A_lin = rgb2lin(image);
    illuminant = illumpca(A_lin);
    B_lin = chromadapt(A_lin, illuminant, 'ColorSpace','linear-rgb');
    normalized_image = lin2rgb(B_lin);
end