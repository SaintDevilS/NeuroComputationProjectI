classdef ImageCompressionTester < matlab.unittest.TestCase
    properties
        img_comp = ImageCompression();
    end
    methods (Test)
        function test_split_image(testCase)
            mat_of_img = rand(16);
            
            blocks_of_mat = testCase.img_comp.split_image(mat_of_img);
            
            dims_of_blocks = size(blocks_of_mat);
            testCase.verifyEqual(dims_of_blocks(1), 8);
            testCase.verifyEqual(dims_of_blocks(2), 8);
            testCase.verifyEqual(dims_of_blocks(3), 2);
            testCase.verifyEqual(dims_of_blocks(4), 2);
        end
        
        function test_join_blocks_of_img(testCase)
            blocks = [1 2; 3 4];
            blocks(:, :, 1, 2) = [5 6; 7 8];
            blocks(:, :, 2, 1) = [9 10; 11 12];
            blocks(:, :, 2, 2) = [13 14; 15 16];
            
            img = testCase.img_comp.join_blocks(blocks);
            
            expected_img = [1 2 5 6; 3 4 7 8; 9 10 13 14; 11 12 15 16];
            
            testCase.verifyEqual(img, expected_img);
        end
        
        function test_split_and_join1(testCase)
            img = [1 2 5 6; 3 4 7 8; 9 10 13 14; 11 12 15 16];
            
            blocks_of_img = testCase.img_comp.split_image(img);
            
            after_merge_img = testCase.img_comp.join_blocks(blocks_of_img);
            
            testCase.verifyEqual(after_merge_img, img);
        end
        
        function test_split_and_join(testCase)
            img = imread('LENNA.JPG');
            
            blocks_of_img = testCase.img_comp.split_image(img);
            
            after_merge_img = testCase.img_comp.join_blocks(blocks_of_img);
            
            testCase.verifyEqual(after_merge_img, img);
        end
    end
    
end