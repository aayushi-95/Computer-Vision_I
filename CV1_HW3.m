clc;
clear all;
close all;

picture = double(imread('Image.bmp'));
org_img = imread('Image.bmp');

%Histogram
[m,n] = size(picture);
mn = m*n;
histogram = zeros(1,256);
val_pix = picture;
for m1 = 1:1:m
    for n1 = 1:1:n
        histogram(val_pix(m1,n1)) = histogram(val_pix(m1,n1)) + 1;
    end
end


%To detrmine the largest dip in the histogram and then the threshold
t1 = input('Enter threshold t1');
t2 = input('Enter threshold t2');
s = sum(picture)
tot = sum(s)
avg = tot/(m*n)
pic = picture;

for m1 = 1:1:m
    for n1 = 1:1:n
        if picture(m1,n1)<t1
            pic(m1,n1) = 0;
        elseif picture(m1,n1)>t2
            pic(m1,n1) = 0;
        else
            pic(m1,n1) = 255;
        end
    end
end

%To find CDF

cdf1(:,1) = histogram(:,1);
for i = 2:1:256
    cdf1(1,i) = cdf1(:,i-1) + histogram(:,i);
end

for n1 = 1:1:256
    if cdf1(1,n1)>(0.05*mn)
      hist_c = n1;
      break;
    end
end

for n1 = 256:-1:1
  if cdf1(1,n1)<0.95*mn
    hist_d = n1+1;
    break;
   end
end

%Contrast stretching
hist_a = 0;
hist_b = 255;
for m1 = 1:1:m
    for n1 = 1:1:n
        con_img(m1,n1) = int8(floor(((picture(m1,n1)-hist_c)/(hist_d-hist_c))*(hist_b-hist_a) + hist_a));
    end
end

%Gamma Correction
r = max(picture);
i = max(r)
c = floor(255/((double(i))^double(0.4)));
r = double(0.4);
for m1 = 1:m
    for n1 = 1:n
        gam(m1,n1) = floor((c*((picture(m1,n1)^r))));
    end
end


%To perform histogram equalization
% Equation is floor((L-1)*CDF)
pdf1 = cdf1/(m*n);
x_ = floor(pdf1*255);

% To assign to a new histogram
for m1 = 1:1:m
    for n1 = 1:1:n
        newhist = x_(:,picture(m1,n1));
        hist_equ(m1,n1) = newhist;
    end
end

%Displaying the images

figure(1)
imshow(org_img)
title('Original Image');

figure(2)
plot(histogram)
title('Histogram plot');
max(histogram);
axis([0 255 0 24429])

figure(3)
imshow(pic)
title('Threshold Image');

figure(4)
imshow(con_img)
title('Contrast Stretched Image')

figure(5)
imshow(gam,[])
title('Gamma Correction Image')

figure(6)
imshow(hist_equ,[])
title('Histogram Equalization Image')


    