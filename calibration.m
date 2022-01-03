clear all
clc

BIAS_DIR = 'DIIP-images-bias';
DARK_DIR = 'DIIP-images-dark';
FLAT_DIR = 'DIIP-images-flat';
MEASUREMENT_1_DIR = 'DIIP-images-measurements-1';
MEASUREMENT_2_DIR = 'DIIP-images-measurements-2';

BIAS_PATHS = find_images_paths(BIAS_DIR);
DARK_PATHS = find_images_paths(DARK_DIR);
FLAT_PATHS = find_images_paths(FLAT_DIR);
MEASUREMENT_1_PATHS = find_images_paths(MEASUREMENT_1_DIR);
MEASUREMENT_2_PATHS = find_images_paths(MEASUREMENT_2_DIR);

MEASUREMENT_1_COUNT = length(MEASUREMENT_1_PATHS);
MEASUREMENT_2_COUNT = length(MEASUREMENT_2_PATHS);

for i = 1:MEASUREMENT_1_COUNT
    cimg = calibrate_image(MEASUREMENT_1_PATHS(i),BIAS_PATHS,DARK_PATHS,FLAT_PATHS);
    imwrite(cimg,strcat('measurement_1_',num2str(i),'.JPG'));
end
for i = 1:MEASUREMENT_2_COUNT
    cimg = calibrate_image(MEASUREMENT_2_PATHS(i),BIAS_PATHS,DARK_PATHS,FLAT_PATHS);
    imwrite(cimg,strcat('measurement_2_',num2str(i),'.JPG'));
end

