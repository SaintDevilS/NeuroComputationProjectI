img = imread('LENNA.JPG');
seg = segment_image(img);

[W1,W2] = train_nn(seg(1,1),nan,nan);
for i=1:(size(img,1)/m)
    for j=1:(size(img,1)/m)
        [W1,W2] =train_nn(seg(i,j,:,:),W1,W2);
    end
end