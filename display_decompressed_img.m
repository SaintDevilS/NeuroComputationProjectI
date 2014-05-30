function display_decompressed_img ( )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    load('weights'); 
    
    ict = ImageCompression();
    
    output_blocks = ict.put_all_blocks_through_weights(blocks_of_img, W1, W2);
    
    normed_img = ict.join_blocks(output_blocks);
    img = ict.normed_img_to_grayscale(normed_img);
    
    imshow(img);
    

end

