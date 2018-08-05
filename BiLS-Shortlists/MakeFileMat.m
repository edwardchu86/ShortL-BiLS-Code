function MakeFileMat()
clc;
clear all;
close all;
for i = 425
    for j = i:i+9
        fprintf('\ni = %d',i);
        filename1 = ['..\inputs\test\men',num2str(j),'.mat'];
        filename2 = ['..\inputs\test\women',num2str(j),'.mat'];
        %create data file
        x = randn(i,i);
        [x,menList] = sort(x,2);
        y = randn(i,i);
        [y,womenList] = sort(y,2);     
        %comments if not want to overwite
        save(filename1,'menList');
        save(filename2,'womenList');
    end
end
end
%*******************************************************************