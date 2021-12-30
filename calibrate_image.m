function c_img = calibrate_image(R_PATH,B_PATHS,D_PATHS, F_PATHS)
% Calibrates raw image of given path R_PATH using bias images (of paths:
% B_PATHS), dark images (of paths: D_PATHS) and flat images (of paths: F_PATHS)

B_COUNT = length(B_PATHS);
D_COUNT = length(D_PATHS);
F_COUNT = length(F_PATHS);

B = loading_calibration_images(B_PATHS, B_COUNT);
D = loading_calibration_images(D_PATHS, D_COUNT);
F = loading_calibration_images(F_PATHS, F_COUNT);
R = load_image(R_PATH);

B_mean = mean(B,1);

D = D - B_mean;
F = F - B_mean;

[height, width, channels]=size(R);

R = R - reshape(B_mean,height,width,channels);

D_mean = mean(D,1);

R = R - reshape(D_mean,height,width,channels);
F = F - D_mean;

F_sum = sum(F,1);
F_mean = mean(F_sum,1);

F_prim = F_sum - F_mean + 1;

c_img = R./reshape(F_prim,height,width,channels);
end

function img = loading_calibration_images(PATH, COUNT)
    for i = 1:COUNT
        img(i,:,:,:) = load_image(PATH(i));
    end
end