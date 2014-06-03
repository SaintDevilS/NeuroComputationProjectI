function compress_and_decompress_image ( blocks_of_img)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    load('weights', 'W1', 'W2'); 
    
    ict = ImageCompression();
    
    % compression
    compressed_blocks = ict.put_blocks_through_first_weight(blocks_of_img, W1);
    
%    save('compressed_blocks', 'compressed_blocks');
    
    % decompression 
    decompressed_blocks = ict.put_compressed_blocks_through_second_weight(compressed_blocks, W2);
    
    decompressed_img = ict.join_blocks(decompressed_blocks);
    img = ict.decompressed_img_to_grayscale(decompressed_img);
    
    imshow(img);
    
end

