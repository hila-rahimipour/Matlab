%Hila Rahimipour, Ariel Yonayev and Yonatan Gan Zvi :D
%% Stage 1
%loading data from file
clear
load NumbersData

%displaying the first image
a = reshape(x(:,1),20,20);
imagesc(a)
colormap('gray')

%adding one's line to x matrix
x = [x; ones(1,5000)];

%creating thr t matrix
t = zeros(10,5000);
for i=1:length(Digit)
    if Digit(i)==1
        t(1,i)=1;
    elseif Digit(i)==2
        t(2, i)=1;
    elseif Digit(i)==3
        t(3, i)=1;
    elseif Digit(i)==4
        t(4, i)=1;
    elseif Digit(i)==5
        t(5, i)=1;
    elseif Digit(i)==6
        t(6, i)=1;
    elseif Digit(i)==7
        t(7, i)=1;
    elseif Digit(i)==8
        t(8, i)=1;
    elseif Digit(i)==9
        t(9, i)=1;
    elseif Digit(i)==10
        t(10, i)=1;
    end
end

%random w values for each neuron and input and setting lr, error goal and
%max iteration values
w = rand(10, 401)/5-0.1;
lr = 0.1;
ErrorGoal = 0.3;
MaxIterations = 3000;

%% Stage 2

%calling the function
[w, AllCosts,NumIterations] = GradientDescentMultiClass (x, t, w, lr, ErrorGoal,MaxIterations);
%creating y and calculating the range of it
y = logsig(w*x);
minimum = min(min(y));
maximum = max(max(y));

%refreshing w values
w = rand(10, 401)/5-0.1;

%showing images of y and t to see the differences between the answer and
%the result
figure
imagesc(y)
title('result')
figure
imagesc(t)
title('correct answer')

%calculating the success percentage
[C, output] = max(y);
[CT, target] = max(t);
Correct = eq(target, output);
Percentage = (sum(Correct)/length(Correct))*100;


%creating Train group and Test group randomly and their correct answers
index = randperm(5000);
Train = x(:, index(1));
Test = x(:, index(3501));

t_Train = t(:, index(1));
t_Test = t(:, index(3501));

for i=2:3500
    temp = x(:,index(i));
    Train = [Train, temp];
    t_Train = [t_Train, t(:, index(i))];

end

for i=3502:5000
    temp = x(:,index(i));
    Test = [Test, temp];
    t_Test = [t_Test, t(:, index(i))];
end
clear temp

figure
[w, AllCosts_b, NumIterations_b] = GradientDescentMultiClass (Train, t_Train, w, 0.1, 0.3, 300);

%calculating the success percentage of training group
y_Train = logsig(w*Train);
[C_Train, output_Train] = max(y_Train);
[CT_Train, target_Train] = max(t_Train);
Correct_Train = eq(target_Train, output_Train);
Percentage_Train = (sum(Correct_Train)/length(Correct_Train))*100;

figure
imagesc(y_Train)
title('result Train')
figure
imagesc(t_Train)
title('correct answer Train')

%calculating the success percentage of test group using data from training
%group
y_Test = logsig(w*Test);
[C_Test, output_Test] = max(y_Test);
[CT_Test, target_Test] = max(t_Test);
Correct_Test = eq(target_Test, output_Test);
Percentage_Test = (sum(Correct_Test)/length(Correct_Test))*100;

figure
imagesc(y_Test)
title('result Test')
figure
imagesc(t_Test)
title('correct answer Test')
