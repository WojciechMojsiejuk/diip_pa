function paths = find_images_paths(directory)
img = imageSet(directory, 'recursive');
paths = img.ImageLocation;
end
