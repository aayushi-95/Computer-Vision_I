function eI = eroded(eroded_Icopy,r,c,se)
s =5;
% se = [0 1 0; 1 1 1; 0 1 0]; % Structure element
eroded_I = zeros(r,c);
for loop = 1:5
    for i = 2 : r-1
        for j = 2 : c-1
            c1 = [eroded_Icopy(i-1,j-1)*se(1) eroded_Icopy(i-1,j)*se(2) eroded_Icopy(i-1,j+1)*se(3) eroded_Icopy(i,j-1)*se(4) eroded_Icopy(i,j)*se(5) eroded_Icopy(i,j+1)*se(6) eroded_Icopy(i+1,j-1)*se(7) eroded_Icopy(i+1,j)*se(8) eroded_Icopy(i+1,j+1)*se(9)];
            if sum(c1) >= s
                eroded_I(i,j) = 1;
            end
        end
    end
    eroded_Icopy = eroded_I;
end

eI = eroded_I;
end