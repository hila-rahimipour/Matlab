%ARIEL RAPAPORT AND HILA RAHIMIPOUR
clear
learning_rate = 0.01;

%assigning x axis boundries and assigning function
x = [-2.6:0.1:2.6];
y = -30*x+10*x.^3-x.^5;

%showing the graph
plot(x,y)
grid on
xlabel('x axis')
ylabel('y axis')
title('start at -1.1')
hold all

%calculating the minimum point and showing the track over the graph
x = -1.1;
plot(x,-30*x+10*x.^3-x.^5,'.r','MarkerSize',20)
pause(0.2)
for i=1:30
    x = x +(-(-30+30*x.^2-5*x.^4))*learning_rate;
    plot(x,-30*x+10*x.^3-x.^5,'.r','MarkerSize',20)
    pause(0.2)
end
