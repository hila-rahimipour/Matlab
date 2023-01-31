%Hila Rahimipour, Ariel Yonayev, Yonatan Gan Zvi :D
%% Stage 3
clear
%load data
load TrainingData 
%Restarts the random number generation in Matlab and creating neuron
%network with 100 neurons in the mid layer
rng('shuffle') 
net = patternnet(100);

%checking function for layer 1 (mid layer)
net.layers{1}.transferFcn

[net tr] = train(net, x_Hist, t);
%getting results and result range
y = net(x_Hist);
minimum = min(min(y));
maximum = max(max(y));

[PerSuccTrain,PerSuccTest] = EvaluateNetwork1(x_Hist,t,net,tr);

[Conf_Test, Conf_Train] = EvaluateNetwork2(x_Hist,t,net,tr);
