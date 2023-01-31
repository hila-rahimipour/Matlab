%Hila Rahimipour, Ariel Yonayev, Yonatan Gan Zvi :D
function [PerSuccTrain,PerSuccTest] = EvaluateNetwork1(x,t,net,tr)
%dividing to test and train groups and setting their x and t
x_Train = [];
x_Test = [];

t_Train = [];
t_Test = [];
disp(length(tr.trainInd))
for i=1:length(tr.trainInd)
    x_Train = [x_Train, x(:, tr.trainInd(i))];
    t_Train = [t_Train, t(:, tr.trainInd(i))];
end

for i=1:length(tr.testInd)
    x_Test = [x_Test, x(:, tr.testInd(i))];
    t_Test = [t_Test, t(:, tr.testInd(i))];
end


%getting results for the different groups
y_Train = net(x_Train);
y_Test = net(x_Test);

%calculating the success percentage of each group
[C_Train, output_Train] = max(y_Train);
[CT_Train, target_Train] = max(t_Train);
Correct_Train = eq(target_Train,output_Train);
PerSuccTrain = (sum(Correct_Train)/length(Correct_Train))*100;

[C_Test, output_Test] = max(y_Test);
[CT_Test, target_Test] = max(t_Test);
Correct_Test = eq(target_Test,output_Test);
PerSuccTest = (sum(Correct_Test)/length(Correct_Test))*100;

end

