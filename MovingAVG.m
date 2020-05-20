clc;
clear all;
close all;

I = imread('Image.bmp');
kernel = ones(5, 5);
W=25;

kernel = kernel/W;

[r,c] = size(I);
O = zeros(r,c);
    
    I_pad=zeros(r+2*2,c+2*2);
    I_pad(1+2:r+2,1+2:c+2)=I(:,:);

for i=1:r
	for j = 1:c
		tot = I_pad(i:i+4, j:j+4);
		tot = double(tot);
		mult = tot.*kernel;
		O(i, j) = sum(mult(:));
	end
end
O = uint8(O);

figure(1)
imshow(I);
title('Input Image');

figure(2)
imshow(O)
title('Output Image with Moving Average Filter');