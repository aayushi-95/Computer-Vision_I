
num = 100;
x = 0 + (1+0)*rand(100,2);
d = [];
c1 = [];
c2 = [];
for i = 1:num
    if x(i,1) < (0.2 * sin(10*x(i,1)) + 0.3)
        d(i)=1;
        c1(i)=x(i);
    elseif((x(i,1) - 0.8)^2 + (x(i,1) - 0.5)^2 < 0.15^2)
         d(i)=1;
         c1(i)=x(i);
    else
        d(i)=-1;
        c2(i)=x(i);
    end
end
y=d;
%define kernel
K =zeros(num,num);
for i = 1:num
    for j = 1:num
        K(i,j) = polynomial_kernel(x(i), x(j));
    end
end

% QP 
P = (y.*y*K);
q = ones(num * -1);
% G = matrix(ones(num) * -1);
G = zeros(100, 100);
for i = 1:100
    for j=1:100
   if(i==j)
       G(i,j)=-1;
   end
    end
end

h = (zeros(100));

%Lagrange
aplha = quadprog(P, q, G, h);

% alpha = np.ravel(solution['x'])

alpha=0;
sv1_x = [];
sv1_y = [];
sv2_x = [];
sv2_y = [];

for i = 1:100
    if(alpha(i)>1e-5)
        if y(i) == 1
            sv1_x(i) = x(i);
            sv1_y(i) = y(i);
        if y(i) == -1
           sv2_x(i) = x(i);
            sv2_y(i) = y(i);
        end
        end
    end
end

sv_x = sv1_x + sv2_x;
sv_y = sv1_y + sv2_y;

theta = sv_y(1);
for i =1:100
    theta = theta - alpha(i)*y(i)*polynomial_kernel(x(1), sv_x(1))
end

x_coord = linspace(0.0,1.0,1000);
y_coord = linspace(0.0,1.0,1000);

z= zeros(2);
h_plus = [];
h_minus = [];

counter = 1;    

% fig, ax = plt.subplots(figsize=(10,10))
scatter(c1,'red','Class 1');
% scatter(*zip(*c2), c = 'green', label = 'Class -1')
% scatter(*zip(*h_plus), c = 'red',s=1, label = 'Hyperplane 1')
% scatter(*zip(*h), c = 'blue',s=1, label = 'Margin')
% scatter(*zip(*h_minus), c = 'green', s=1, label = 'Hyperplane -1')
% plt.scatter(*zip(*sv_x), facecolors = 'none', edgecolors='black',label='Support Vectors')
% plt.legend(loc = 'best')
% plt.show()


