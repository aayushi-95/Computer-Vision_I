clc;
clear all;
close all;

I = imread('Image.bmp');

[r,c] = size(I);
O = zeros(r,c);


 I_pad=zeros(r+2*2,c+2*2);
    I_pad(1+2:r+2,1+2:c+2)=I(:,:);



kernel =[0.003 0.0133 0.0219 0.0133 0.003; 
         0.0133 0.0596 0.0983 0.0596 0.0133; 
         0.0219 0.0983 0.1621 0.0983 0.0219; 
         0.0133 0.0596 0.0983 0.0596 0.0133; 
         0.003 0.0133 0.0219 0.0133 0.003];

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
title('Output Image with Gaussian Filter');