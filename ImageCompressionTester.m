classdef ImageCompressionTester
    %This class receives an image and compresses it using Back Propagation Algorithm
    %  It is based on the article: Digital Image Compression Enhancement Using Bipolar Backpropagation Neural Networks
    
    properties
    end
    
    methods
        function norm_img = normalize_image(obj, image)
            % this function accepts a grayscale image and normalizes it to
            % be between -1:1
            [m,n] = size(image);
            norm_img = zeros(m,n);
            for i = 1:m
                for j = 1:n
                    norm_img(i,j) = (double(image(i,j)) - 128) / 128;
                end
            end
        end
        
        function blocks_of_img = split_image(obj, image)
            
            block_size = [8,8];
            [rows, cols] = size(image);

            num_of_blocks = [rows / block_size(1), cols / block_size(2)];
            
            
        end
    end
end

