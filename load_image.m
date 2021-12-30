function img = load_image(path)
    img = im2double(imread(cell2mat(path)));
end