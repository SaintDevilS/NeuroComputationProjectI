img = imread('LENNA.JPG');
ict = ImageCompression

normed = ict.normalize_image(img);
blocks_of_img = ict.split_image(normed);
[W1, W2] = ict.train_on_blocks(blocks_of_img)