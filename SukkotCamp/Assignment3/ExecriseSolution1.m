%Hila Rahimipour, Ariel Yonayev, Yonatan Gan Zvi

%% Stage 1
%loading data
load BrainTumors

%displaying first image
imagesc(MRI{1});
colormap('gray')

%find index
OneIndex = find(TumorType==1,3);
TwoIndex = find(TumorType==2,3);
ThreeIndex = find(TumorType==3,3);

%displaying different images
figure
imagesc(MRI{1});
colormap('gray')

figure
imagesc(MRI{209});
colormap('gray')

figure
imagesc(MRI{59});
colormap('gray')

%converting image 1 to black and white, displaying histogram and
%calculating histogram vector
a = mat2gray(MRI{1});
imhist(a, 25)
b = imhist(a,25);

%changing resolution to 50*50
c = imresize(a,[50,50]);

%displaying the new image
imagesc(c);
colormap('gray')

%change the image into vector
d = c(:);

%creating an array with the new info- pics with resolution of 50*50 and
%another array with histogram info
x_Resize = [];
x_Hist = [];
t = zeros(3,3064);

for i=1:3064
    a = mat2gray(MRI{i});
    b = imhist(a,25);
    c = imresize(a,[50,50]);
    d = c(:);
    
    x_Resize = [x_Resize, d];
    x_Hist = [x_Hist, b];
    
    if TumorType(i)==1
        t(1,i)=1;
    elseif TumorType(i)==2
        t(2,i)=1;
    elseif TumorType(i)==3
        t(3,i)=1;
    end

end

%saving data to file
save('TrainingData', 'x_Resize', 'x_Hist', 't');


