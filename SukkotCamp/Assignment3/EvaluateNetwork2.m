%Hila Rahimipour, Ariel Yonayev, Yonatan Gan Zvi :D
function [Conf_Test, Conf_Train] = EvaluateNetwork2(x,t,net,tr)
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

%creating zeros matrix
Conf_Train = zeros(3,3);
Conf_Test = zeros(3,3);

%getting a vector of target output and the final output of train group and test group
[C_Train, output_Train] = max(y_Train);
[CT_Train, target_Train] = max(t_Train);

[C_Test, output_Test] = max(y_Test);
[CT_Test, target_Test] = max(t_Test);

%classifaing the results to see errors per output (Train group)
for i=1:length(output_Train)
    Conf_Train(output_Train(i), target_Train(i)) = Conf_Train(output_Train(i), target_Train(i))+1;
    
end

%classifaing the results to see errors per output (Test group)
for i=1:length(output_Test)
    Conf_Test(output_Test(i), target_Test(i)) = Conf_Test(output_Test(i), target_Test(i))+1;
    
end


end

