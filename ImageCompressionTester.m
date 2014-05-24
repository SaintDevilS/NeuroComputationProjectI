classdef ImageCompressionTester
    %This class receives an image and compresses it using Back Propagation Algorithm
    %  It is based on the article: Digital Image Compression Enhancement Using Bipolar Backpropagation Neural Networks
    
    properties
    end
    
    methods
        function norm_img = normalize_image(obj, image)
            [m,n] = size(image);
            norm_img = zeros(m,n);
            for i = 1:m
                for j = 1:n
                    norm_img(i,j) = (double(image(i,j)) - 128) / 128;
                end
            end
        end
    end
end

