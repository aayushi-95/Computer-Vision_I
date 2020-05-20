function result =  histogram(I,r,c)
histo = zeros(1,256);

for i = 1 : r
    for j = 1 : c
        pval = I(i,j);
        histo(pval + 1) = histo (pval + 1) + 1;        
    end
end

result = histo;
end