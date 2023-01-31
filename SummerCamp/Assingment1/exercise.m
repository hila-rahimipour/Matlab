%ARIEL RAPAPORT AND HILA RAHIMIPOUR
clear
learning_rate = 0.01;

%assigning x axis boundries and assigning function
x = [-3:0.1:1];
y = x.^2+2*x+5;

%showing the graph
plot(x, y)
grid on
xlabel('x axis')
ylabel('y axis')
title('exersice')

hold all

%calculating the minimum point and showing the track over the graph
x = 0;
plot(x,x^2+2*x+5,'.r','MarkerSize',20)
pause(0.2)
for i=1:30
    x = x +(-(2*x+2))*learning_rate;
    plot(x,x^2+2*x+5,'.r','MarkerSize',20)
    pause(0.2)
end


