%Hila Rahimipour, Ariel Yonayev and Yonatan Gan Zvi :D

clear
%loading data from file
load StrokeData
%% displaying the different test scores of the patients (Stage 1)
%going over the matrix and searching for value of 1 in Stroke matrix which
%indicates of having a stroke. if the person has a stroke, it will show his
%data(results in test1 and 2) with blue color and if not it will appear in red

for i=1:100
    if Stroke(i)==1
        plot(NeuroExam1(i), NeuroExam2(i), '.b')
    else
        plot(NeuroExam1(i), NeuroExam2(i), '.r')
    end
    ylabel('exam 2');
    xlabel('exam 1');
    hold all
end
%% Stage 2
%assigning variables
x = [NeuroExam1; NeuroExam2; ones(1,100)];
t = Stroke;
w = rand(1,3)/5-0.1;
lr = 0.1;
ErrorGoal = 0.01;
MaxIterations = 10000;

%calling the function
figure
[w, AllCosts,NumIterations] = GradientDescent (x, t, w, lr, ErrorGoal,MaxIterations);


%% Plot the decision boundary (Stage 3)
% get two points
a_x = min(NeuroExam1);
b_x = max(NeuroExam2);
% calculate the y-axis on the line of the descision boundary for these
% points:
a_y = (w(1)*a_x+w(3))/-w(2);
b_y = (w(1)*b_x+w(3))/-w(2);
figure
plot(NeuroExam1(Stroke==0),NeuroExam2(Stroke==0),'or')
hold on
plot(NeuroExam1(Stroke==1),NeuroExam2(Stroke==1),'ob')
plot([a_x,b_x],[a_y,b_y],'k')
ylabel('exam 2');
xlabel('exam 1');

%% Stage 3, exercise 8-12
output = logsig(w*x);
desicion = [];
errors = 0;
%calculating if the person will have a stroke or not and calculating the
%amout of errors the algorithm did
for i=1:100
    if output(i)<0.5
        desicion=[desicion, 0];
        
    else
         desicion=[desicion, 1];
    end
    if desicion(i)~=t(i)
            errors = errors+1;
    end
end
%calculating the success percentage
SuccessPer = 100-errors;

    

