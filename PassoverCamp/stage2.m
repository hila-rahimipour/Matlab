%%Hila Rahimipour
clear
%assigning variables
mat = zeros(100, 100);
mat(length(mat)/2-4:length(mat)/2+5,1:10)=1;

%displaying the matrix as a picture (black & white)
imagesc(mat);
colormap('gray')

%moving the rectangle horizontaly
for i=1:100
    if (i>11)
        mat = zeros(100, 100);
        mat(length(mat)/2-4:length(mat)/2+5,i-10:i)=1;
        imagesc(mat);
        colormap('gray')
        pause(0.1)
    end
end