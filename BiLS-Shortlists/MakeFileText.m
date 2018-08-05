function MakeFileText()
clc;
clear all;
close all;
for i = 1:5
    n = 500;
    filename1 = ['..\inputs\test2\men',num2str(n+i),'.txt'];
    filename2 = ['..\inputs\test2\women',num2str(n+i),'.txt'];
    createfile(filename1,filename2,n);
end
end
%*******************************************************************
function createfile(filename1,filename2,n)
%create data file
x = randn(n,n);
[x,m] = sort(x,2);
x     = randn(n,n);
[x,w] = sort(x,2);

%write to file
fin = fopen(filename1','w');
fprintf(fin,'%5d\n',n);
for i = 1:n
    for j = 1:n
        fprintf(fin,'%5d',m(i,j));
    end
    fprintf(fin,'\n');
end
fclose(fin);

%write to file
fin = fopen(filename2,'w');
fprintf(fin,'%5d\n',n);
for i = 1:n
    for j = 1:n
        fprintf(fin,'%5d',w(i,j));
    end
    fprintf(fin,'\n');
end
fclose(fin);
end