function display_reconstructed_img ( )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    before_img = imread('LENNA.JPG');
    load('weights'); 
    
    ict = ImageCompression();
    
    normed_img = ict.join_blocks(blocks_of_img);
    img = ict.normed_img_to_grayscale(normed_img);
    
    imshow(uint8(img));
    

end

