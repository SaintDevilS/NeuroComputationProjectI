function compress_and_decompress_image (img)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    load('weights', 'W1', 'W2'); 
    
    ict = ImageCompression();
    
    normed = ict.normalize_image(img);
    blocks_of_img = ict.split_image(normed, 8, 8);
    

    % compression
    compressed_blocks = ict.put_blocks_through_first_weight(blocks_of_img, W1);
    
%    save('compressed_blocks', 'compressed_blocks');
    
    % decompression 
    decompressed_blocks = ict.put_compressed_blocks_through_second_weight(compressed_blocks, W2);
    
    decompressed_img = ict.join_blocks(decompressed_blocks);
    img = ict.decompressed_img_to_grayscale(decompressed_img);
    
    imshow(img);
    
end