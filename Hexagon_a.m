clc;
clear all;
close all;

%Creating a Hexagon
% fig = [-1 -.5 .5 1 .5 -.5 -1;0 .866 .866 0 -.866 -.866 0];

fig = [-2 -1 1 2 1 -1 -2;0 1.732 1.732 0 -1.732 -1.732 0];
%Plottinig the shape

figure(1)
plot(fig(1,1:end),fig(2,1:end),'rx-');
axis([-4 10 -4 10])

%Translation

%Creating [I t] for equation p'=[I t]p
%Assigning values for t1 and t2 and proceeding
t1=5;
t2=5;
It1=[1 0 t1;0 1 t2;0 0 1];
paugu= [fig;1 1 1 1 1 1 1]    %paug is augmented vector
p1= It1*paugu

%Plotting both figures together
hold on
plot(p1(1,1:end),p1(2,1:end),'kx-');
axis([-4 10 -4 10])
title('2D Translation');
xlabel('X-axis');
ylabel('Y-axis');
grid on;
legend('Original','Transformed');
hold off

%Setting w value and obtaining homogenous values
w = 2;
hom1 = w*p1 

%Rotation

%Formula for rotation is p'= [R t]*Paug
% assuming angle is 30 degrees
Rt = [cos(30) -sin(30) t1; sin(30) cos(30) t2; 0 0 1];
p2 = Rt*paugu
hom2 = w*p2 

figure(2)
plot(fig(1,1:end),fig(2,1:end),'rx-');
axis([-6 6 -6 6])

hold on
plot(p2(1,1:end),p2(2,1:end),'cx-');
axis([-4 10 -4 10])
title('2D Rotation');
xlabel('X-axis');
ylabel('Y-axis');
grid on;
legend('Original','Transformed');
hold off

%Similarity Transform
%Assuming  a=0.5 and b=0.2, equation is p' = SR*p + t
a= 0.6;
b= 0.3;
SRt = [a -b t1; b a t2; 0 0 1]
p3 = SRt*paugu
hom3 = w*p3

figure(3)
plot(fig(1,1:end),fig(2,1:end),'rx-');

hold on
plot(p3(1,1:end),p3(2,1:end),'yx-');
axis([-4 10 -4 10])
title('Similarity Transform');
xlabel('X-axis');
ylabel('Y-axis');
legend('Original','Transformed');
grid on;
hold off

%Affine Transform
%Equation is p' = A.paug where A is an arbitrary matrix of size 2x3
A = [0.2 1 0.3;0.4 0.5 0.6];
p4 = A*paugu
hom4 = w*p4

figure(4)
plot(fig(1,1:end),fig(2,1:end),'rx-');
axis([-6 6 -6 6])
hold on
plot(p4(1,1:end),p4(2,1:end),'mx-');
title('Affine Transform');
axis([-6 6 -6 6])
xlabel('X-axis');
ylabel('Y-axis');
legend('Original','Transformed');
grid on;
hold off;

%Projective Transform
%Equation is p~'=H~*p
% H = [1 5 2; 0 1 5 ; 2 1 5];
H = [1 5 2; 0 1 5 ; 2 1 5];
%Homogenous Coordinates.
p5_= H*paugu                        
%Inhomogenous Coordinates
p5 = [p5_(1,1:7)./(p5_(3,1:7));p5_(2,1:7)./(p5_(3,1:7));p5_(3,1:7)./(p5_(3,1:7))]   

figure(5)
plot(fig(1,1:end),fig(2,1:end),'rx-');

hold on
plot(p5(1,1:end),p5(2,1:end),'gx-');
axis([-8 8 -8 8])
title('Projective Transform');
xlabel('X-axis');
ylabel('Y-axis');
legend('Original','Transformed');
grid on;

