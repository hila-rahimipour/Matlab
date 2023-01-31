%Hila Rahimipour, Ariel Yonayev and Yonatan Gan Zvi :D
function [w, AllCosts,NumIterations] = GradientDescent (x, t, w, lr, ErrorGoal,MaxIterations)

%assigning variables and calculating current error(cost) by cost function
y = logsig(w*x);
CurrentCost = -(1/length(x))*sum((t.*log(y)+(1-t).*log(1-y)));
NumIterations = 0;
AllCosts = CurrentCost;

%the loop runs until the Current Error will be less than the Error Goal or
%until it will reach the MaxIterations
while CurrentCost > ErrorGoal && NumIterations < MaxIterations
    %gradiant vector
    grad = (-(t-y)*x')/length(x);
    %calculating current w
    w = w-lr*grad;
    %calculating current output
    y = logsig(w*x);
    %calculating current error and adding to AllCosts
    CurrentCost = -(1/length(x))*sum((t.*log(y)+(1-t).*log(1-y)));
    AllCosts = [AllCosts, CurrentCost];
    NumIterations = NumIterations + 1;
end

%displaying a graph that shows the change of the error rate through each
%iteration
plot(AllCosts, '-g')
xlabel('Iterations');
ylabel('Cost');
title('Error function')

end
