function [seg]=segment_image(img)
%img- gray level image of size=x**2
%seg= a block X block X m X m array contain the segmented block in the
%image
m = 16;
seg=zeros(size(img,1)/m,size(img,1)/m,m,m);

for i=1:(size(img,1)/m)
    for j=1:(size(img,1)/m)
        seg(:,:,j,i)=img(m*(i-1)+ 1:m*i,m*(j-1)+ 1:m*j); 
    end
end
