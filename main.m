img = imread('LENNA.JPG');
ict = ImageCompressionTester
normed = ict.normalize_image(img);
lol = ict.split_image(normed);