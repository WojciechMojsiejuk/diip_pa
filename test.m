cii = coins_in_images;
B_mean = imread('B_mean.JPG');
D_mean = imread('D_mean.JPG');
F_mean = imread('F_mean.JPG');

for i = 1:12
    name = strcat(num2str(i),'.JPG');
    R = imread(name);
    estim_coins(R,B_mean, D_mean, F_mean)
    correct = flip(cii(i,:))
end