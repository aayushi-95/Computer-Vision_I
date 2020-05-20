function result = absoluteDifference(dilated_I,I_negative,r,c)
diff_5 = dilated_I -  I_negative;
for i = 1 : r
    for j = 1 : c
        if diff_5(i,j) < 0
            diff_5(i,j) = 1;
        end
    end
end

diff_5_contrast = (diff_5 - min(diff_5(:))) / (max(diff_5(:)) - min(diff_5(:)));
for i = 1 : r
    for j = 1 : c
        if diff_5_contrast(i,j) ~= 0
            diff_5_contrast(i,j) = 1;
        end
    end
end
result = diff_5_contrast;
end