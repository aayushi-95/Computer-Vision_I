clc;
clear all;
close all;


im = imread('Image.bmp');
imwrite(im,'im1.jpg');
im_1 = imread('im1.jpg');
figure()
imshow(im_1);
title('Input Image');
[r,c] = size(im_1);
ix = [-2 -1 0 1 2];
iy = ix';
Ix = conv2(im_1,ix,'same');
Iy = conv2(im_1,iy,'same');
Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;
figure()
imshow(Ix)
title('Derivative applied in Horizontal Direction');
figure()
imshow(Iy)
title('Derivative applied in Vertical Direction');

%Rotated
im_rot = imrotate(im_1,45);
figure()
imshow(im_rot);
title('Rotated Input Image');
[m,c] = size(im_rot);

ix = [-2 -1 0 1 2];
iy = ix';
Ixr = conv2(im_rot,ix,'same');
Iy = conv2(im_rot,iy,'same');
Ix2r = Ixr.^2;
Iy2r = Iy.^2;
Ixy = Ixr.*Iy;
figure()
imshow(Ixr)
title('Derivative applied in Horizontal Direction');
figure()
imshow(Iy)
title('Derivative applied in Vertical Direction');