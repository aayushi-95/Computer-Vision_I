clc
clear all;
close all;

%Read image
I = imread('Connected.bmp');

[r,c] = size(I);

histo = histogram(I,r,c);

for i = 1 : 256
    xaxis(i) = i - 1;
end

%Global Thresholding
%Set Global Threshold value
global_threshold = 100;
image_thresholded = zeros(r,c);
image_thresholded(I>global_threshold) = 1;
image_thresholded(I<=global_threshold) = 0;

image_negative = zeros(r,c);
image_negative(image_thresholded == 1) = 0;
image_negative(image_thresholded == 0) = 1;

connected = zeros(r,c);
connected_counter = 1;
label = [1 : 1 : 10000];

for i = 1 : r
    for j = 1 : c
        if i == 1 && j == 1
                connected(i,j) = label(connected_counter);
                connected_counter = connected_counter + 1;
        elseif image_negative(i,j) == 1
            if i == 1
                if image_negative(i,j-1) == 1
                    connected(i,j) = connected (i,j-1);
                else
                    connected(i,j) = label(connected_counter);
                    connected_counter = connected_counter + 1;
                end
            elseif j == 1
                if image_negative(i-1,j) == 1
                    connected(i,j) = connected (i-1,j);
                else
                    connected(i,j) = label(connected_counter);
                    connected_counter = connected_counter + 1;
                end
            else
                if image_negative(i-1,j) == 1 && image_negative(i,j-1) == 0
                    connected(i,j) = connected (i-1,j);
                elseif image_negative(i-1,j) == 0 && image_negative(i,j-1) == 1
                   connected(i,j) = connected (i,j-1);
                elseif image_negative(i-1,j) == 1 && image_negative(i,j-1) == 1
                    if connected(i-1,j) == connected(i,j-1)
                        connected(i,j) = connected (i-1,j);
                    else
                        connected(connected == connected(i-1,j)) = connected(i,j-1);
                        connected(i,j) = connected (i,j-1);
                    end
                else
                    connected(i,j) = label(connected_counter);
                    connected_counter = connected_counter + 1;
                end
            end
        elseif image_negative(i,j) == 0
            if i == 1
                if image_negative(i,j-1) == 0
                    connected(i,j) = connected (i,j-1);
                else
                    connected(i,j) = label(connected_counter);
                    connected_counter = connected_counter + 1;
                end
            elseif j == 1
                if image_negative(i-1,j) == 0
                    connected(i,j) = connected (i-1,j);
                else
                    connected(i,j) = label(connected_counter);
                    connected_counter = connected_counter + 1;
                end
            else
                if image_negative(i-1,j) == 1 && image_negative(i,j-1) == 0
                    connected(i,j) = connected (i,j-1);
                elseif image_negative(i-1,j) == 0 && image_negative(i,j-1) == 1
                   connected(i,j) = connected (i-1,j);
                elseif image_negative(i-1,j) == 0 && image_negative(i,j-1) == 0
                    if connected(i-1,j) == connected(i,j-1)
                        connected(i,j) = connected (i,j-1);
                    else
                        connected(connected == connected(i-1,j)) = connected(i,j-1);
                        connected(i,j) = connected (i,j-1);
                    end
                else
                    connected(i,j) = label(connected_counter);
                    connected_counter = connected_counter + 1;
                end
            end  
        end
    end
end

conn_equi = unique(connected);
[equivalency_m, equivalency_n] = size(conn_equi);
loop = equivalency_m;

while loop ~= 0
    connected(connected == conn_equi(loop)) = loop - 1;
    loop = loop - 1;
end

conn_equi = size(conn_equi);

connected = connected * 255 / (equivalency_m - 1);

dispaly_varaible = ['There are in total ' , num2str(conn_equi(1)) , ' connected components'];
fprintf(dispaly_varaible);



%Display result
figure(1);
imshow(I); %Display Text.bmp
title('Original image');

figure(2);
plot(xaxis,histo); %Display histogram of orginal image
title('Histogram of image');

figure(3);
imshow((image_negative),[]); %Display thresholded image
title('Negative image');


%Finding the dynamic range
check1 = connected;
check = (check1-min(check1(:)))/(max(check1(:))-min(check1(:)))*255;
figure(4)
imshow(check1,[])
title('Connected Components Image in Full Dynamic Range');

