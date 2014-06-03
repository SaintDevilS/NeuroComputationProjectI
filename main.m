ict = ImageCompression;

%train_and_save_weights();
img = imread('LENNA.JPG');
    
normed = ict.normalize_image(img);
blocks_of_img = ict.split_image(normed, 8, 8);
    
display_decompressed_img(blocks_of_img)