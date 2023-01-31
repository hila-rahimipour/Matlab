%Hila Rahimipour, Ariel Yonayev, Yonatan Gan Zvi :D
%% Stage 4

SuccessRate_Test = [];
SuccessRate_Train = [];

%calculating of success rate for 20 times
for i=1:20
    ExecriseSolution2
    SuccessRate_Test = [SuccessRate, PerSuccTest];
     SuccessRate_Train = [SuccessRate, PerSuccTrain];
    
end

%calculating avg
avg_train = mean(SuccessRate_Train);
avg_test = mean(SuccessRate_Test);
%graphs of the success rates relative to the number of iterations
plot(SuccessRate_Test)
xlabel('iteration number')
ylabel('success test')
figure
plot(SuccessRate_Train)
xlabel('iteration number')
ylabel('success train')