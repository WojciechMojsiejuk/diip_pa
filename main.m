clear all
clc

BIAS_DIR = 'DIIP-images-bias';
DARK_DIR = 'DIIP-images-dark';
FLAT_DIR = 'DIIP-images-dark';
MEASUREMENT_1_DIR = 'DIIP-images-measurements-1';
MEASUREMENT_2_DIR = 'DIIP-images-measurements-2';

BIAS_PATHS = find_images_paths(BIAS_DIR);
DARK_PATHS = find_images_paths(DARK_DIR);
FLAT_PATHS = find_images_paths(FLAT_DIR);
MEASUREMENT_1_PATHS = find_images_paths(MEASUREMENT_1_DIR);
MEASUREMENT_2_PATHS = find_images_paths(MEASUREMENT_2_DIR);


cimg = calibrate_image(MEASUREMENT_1_PATHS(1),BIAS_PATHS,DARK_PATHS,FLAT_PATHS);
imshow(cimg)