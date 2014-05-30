function display_decompressed_img ( )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    load('weights'); 
    load('compressed_blocks');
    
    ict = ImageCompression();
    
    output_blocks = ict.put_compressed_blocks_through_second_weight(compressed_blocks, W2);
    
    normed_img = ict.join_blocks(output_blocks);
    img = ict.decompressed_img_to_grayscale(normed_img);
    
    imshow(img);
    

end

