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
       
    end
    
end