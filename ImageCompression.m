classdef ImageCompression
    %This class receives an image and compresses it using Back Propagation Algorithm
    %  It is based on the article: Digital Image Compression Enhancement Using Bipolar Backpropagation Neural Networks
    
    properties
        first_and_output_layers = 64;
        hidden_layer = 16;    
        iters = 100;
        mew = 0.4;
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
        
        function grayscale_img = normed_img_to_grayscale(obj, norm_img)
            [m, n] = size(norm_img);
            grayscale_img = zeros(m, n);
            
            for i = 1:m
                for j = 1:n
                    grayscale_img(i, j) = norm_img(i, j) * 128 + 128;
                end
            end
            
            grayscale_img = uint8(grayscale_img);
        end
        
        function blocks_of_img = split_image(obj, image, row_size, col_size)            
            [rows, cols] = size(image);
            
            blocks_of_img = zeros(row_size, col_size, rows / row_size, cols / col_size());
            
            for i = 1:rows / row_size
                for j = 1:cols / col_size
                    blocks_of_img(:,:,i,j)=image((i-1)*row_size+1:(i-1)*row_size + col_size, (j-1)*col_size+1:(j-1)*col_size+row_size);
                end
            end
        end
        
        function img = join_blocks(obj, blocks_of_img)
            dims_of_blocks = size(blocks_of_img);
            
            img = zeros( dims_of_blocks(1) * dims_of_blocks(3), dims_of_blocks(2) * dims_of_blocks(4));
            for i = 1:dims_of_blocks(3)
                for j = 1:dims_of_blocks(4)
                    img_row_indices_for_block_i_j = (i-1) * dims_of_blocks(1) + 1: (i-1) * dims_of_blocks(1) + dims_of_blocks(2);
                    img_col_indices_for_block_i_j = (j-1)* dims_of_blocks(2) + 1: (j-1) * dims_of_blocks(2) + dims_of_blocks(1);
                    img( img_row_indices_for_block_i_j , img_col_indices_for_block_i_j) = blocks_of_img(:, :, i, j);
                end
            end
        end
        
        function out_vec = sigmoidal_func_on_each(obj, in_vec)
            sigmoidal_const = 1;
            out_vec = zeros(length(in_vec), 1);
            for i=1:length(in_vec)
                out_vec(i) = 1 / (1 + exp( -sigmoidal_const * in_vec(i)));
            end
        end        
        
        function [corrected_W1, corrected_W2, compressed_block] = train_on_block(obj, a_block, W1, W2)
            if length(W1) == 1
                W1 = randn(obj.first_and_output_layers, obj.hidden_layer);
                W2 = randn(obj.hidden_layer, obj.first_and_output_layers);
            end
            
            weights_of_bias1 = randn(1, obj.hidden_layer);
            weights_of_bias2 = randn(1, obj.first_and_output_layers);
           
            for i = 1:obj.iters
                W1_with_bias = [W1' weights_of_bias1']';
                W2_with_bias = [W2' weights_of_bias2']';

                input_vec = [a_block(:)' 1];

                
                o1 = obj.sigmoidal_func_on_each(input_vec * W1_with_bias);
                o2 =  obj.sigmoidal_func_on_each([o1' 1] * W2_with_bias);
                
                ones_length_of_o1 = ones(length(o1), 1);
                ones_length_of_o2 = ones(length(o2), 1);
                
                D2 = diag(o2 .* (ones_length_of_o2 - o2));
                D1 = diag(o1 .* (ones_length_of_o1 - o1));

                error_vec = (o2 - a_block(:));  % used t = a_block since we want the same thing as the input

                lambda2 = D2 * error_vec;

                lambda1 = D1 * W2 * lambda2;

                W2 = W2 - obj.mew * (lambda2 * o1')';
                W1 = W1 - obj.mew * (lambda1 * a_block(:)')';
            end
            
            corrected_W1 = W1;
            corrected_W2 = W2;
            compressed_block = o1;
        end
        
        function [W1, W2, compressed_blocks] = train_on_blocks(obj, blocks_of_img)
            
            W1 = nan;
            W2 = nan;
            dim_of_blocks = size(blocks_of_img);
            compressed_blocks = zeros( obj.first_and_output_layers / obj.hidden_layer / 2, obj.first_and_output_layers / obj.hidden_layer / 2, dim_of_blocks(3), dim_of_blocks(4));

            for i = 1:dim_of_blocks(3)
                for j = 1:dim_of_blocks(4)
                    
                    [W1, W2, compressed_block] = obj.train_on_block( blocks_of_img(:, :, i, j), W1, W2);
                    compressed_blocks(:, :, i, j) = compressed_block;
                end
            end
        end
        
        function output_blocks_of_img = put_all_blocks_through_weights(obj, blocks_of_img, W1, W2)
            output_blocks_of_img = zeros(size(blocks_of_img));
            dim_of_blocks = size(blocks_of_img);
            
            for i = 1:dim_of_blocks(3)
                for j = 1:dim_of_blocks(4)
                    output_blocks_of_img(:, :, i, j) = vec2mat(obj.put_block_through_weights( blocks_of_img(:, :, i, j), W1, W2), 8);
                end
            end 
        end
        
        function output_block = put_block_through_weights(obj, a_block, W1, W2)
            output_block = a_block(:)' * W1 * W2;
        end
    end
end

