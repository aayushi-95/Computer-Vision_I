clc;
clear all;
close all;
ip_im = imread('checkerboard.jpg');
im = rgb2gray(ip_im);
figure()
imshow(im);
title('Input Image');

[r,c] = size(im);

ix = [-2 -1 0 1 2];
iy = ix';
Ix = conv2(im,ix,'same');
Iy = conv2(im,iy,'same');
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
im_rot = imrotate(im,45);
figure()
imshow(im_rot);
title('Rotated Input Image');
[r,c] = size(im_rot);

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
