function train_and_save_weights( )
%train_and_save_weights 
%   Detailed explanation goes here
    img = imread('LENNA.JPG');
    ict = ImageCompression;

    normed = ict.normalize_image(img);
    blocks_of_img = ict.split_image(normed, 8, 8);
    [W1, W2] = ict.train_on_blocks(blocks_of_img);

    save('weights', 'W1' , 'W2');
%    save('compressed_blocks', 'compressed_blocks');

end

