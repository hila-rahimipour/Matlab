%the function Output recieves variables w, x and b and returns the variable y  
function [y] = Output(w,x,b)
%assigning sum variable
neuron_sum = 0;

% w = [-3 4 2 6 7 8 1 9 -3 -2];
% x = [-2; -3; -9; 1; 8; 7; 6; 2; 4; -3];

%for loop to sum all of the input
for i=1:length(w)
    neuron_sum = neuron_sum + w(i)*x(i);    
end

%substract the b value
neuron_sum = neuron_sum - b;

%checks if there is output or not
if neuron_sum>=0
    y=1;
else
    y=0;
end

end

