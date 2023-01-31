%HILA RAHIMIPOUR AND ARIEL RAPAPORT
%assigning variables
clear
w = [-3 4 2 6 7 8 1 9 -3 -2];
x = [-2; -3; -9; 1; 8; 7; 6; 2; 4; -3];
b = 100;

%applying function on our data
[y] = Output(w,x,b);


%grandma neuron
b_all = 2;
w_all = [1 1];

x1 = [0; 0];
x2 = [0; 1];
x3 = [1; 1];
x4 = [1; 0];

[y1] = Output(w_all,x1,b_all);
[y2] = Output(w_all,x2,b_all);
[y3] = Output(w_all,x3,b_all);
[y4] = Output(w_all,x4,b_all);


%b = neuron threshold for firing an action potential
