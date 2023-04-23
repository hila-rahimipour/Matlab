% this script is a general script of neurofeedback using emotiv 
clear
%%  INPUT PARAMETERS
% Choose the channel's number:
CHANNEL= 11
% LIST OF CHANNELS AND NUMBERS:
% 4 - AF3 % 5 - F7 % 6 - F3 % 7 - FC5 % 8 - T7 % 9 - P7 % 10 - O1
% 11 - O2 %12 - P8 %13 - T8 %14 - FC6 %15 - F4 %16 - F8 %17 - AF4

% Choose the length of the BCI session, in seconds:
runtime = 180


%% Initialize emotiv, do not make changes here
init_emotiv()


%% This is the feedback loop
disp([ 'feedback is for channel:' channelName{CHANNEL}] )
%steps=1;%counter
tic_a= tic;
steps=1;
%% YOUR CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mat = [];
mat (:,:,1) = ones(100,100);
mat(:,:,2)= zeros (100,100);
mat (:,:,3) = zeros (100,100);
alphavec=[];
alphaavg=[];
threshold= 5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
while (toc < runtime)
    % EMOTIV PART
    state = calllib('libIEDK','IEE_EngineGetNextEvent',eEvent);
    if(state == EDK_OK)
        eventType = calllib('libIEDK','IEE_EmoEngineEventGetType',eEvent);
        calllib('libIEDK','IEE_EmoEngineEventGetUserId',eEvent, userIdPtr);
        if (strcmp(eventType,'IEE_UserAdded') == true)
            fprintf('User added: %d', userIdPtr.Value)
            userAdded = true;
        end
    end    
    if (userAdded)
        if strcmp(eventType,'IEE_EmoStateUpdated') == true
            
            % Initialize all frequency bands:
            alphaPtr.Value = 0;% 
            thetaPtr.Value = 0;
            lowBetaPtr.Value = 0;
            highBetaPtr.Value = 0;
            gammaPtr.Value = 0;
            for index = CHANNEL 
                
                % HERE THE ALPHA VALUES ARE EXTRACTED, one can change alpha to other bands such as beta
                res = calllib('libIEDK','IEE_GetAverageBandPowers', userIdPtr.Value, dataChannel.([channelName{index}]), thetaPtr, alphaPtr, lowBetaPtr, highBetaPtr, gammaPtr);
                if (res == EDK_OK)
                    % get the current value of all frequency bands:
                    theta = thetaPtr.Value;
                    alpha = alphaPtr.Value; 
                    lowBeta = lowBetaPtr.Value;    
                    highBeta = highBetaPtr.Value;
                    gamma = gammaPtr.Value;
                    %% YOUR CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                    alphavec = [alphavec, alpha];
                    if length(alphavec)>4
                    alphaavg = mean(alphavec(length(alphavec)-4:length(alphavec)));
                    if alphaavg > threshold & mat(:,:,2) < 1 
                            mat (:,:,1)= mat (:,:,1)-0.01;
                            mat(:,:,2)= mat(:,:,2) + 0.01; 
                    elseif  alphaavg < threshold & mat(:,:,1) < 1 
                        mat (:,:,1)= mat (:,:,1)+ 0.01;
                        mat(:,:,2)= mat(:,:,2) - 0.01; 
                    end 
                    end 
                    if floor(mat(:,:,2))== ones(100,100)
                        return;
                    end 
    figure(1);
    subplot(1,2,1);
    imagesc(mat);
    subplot (1,2,2);
    plot(1:steps,alphavec);
    xlabel('number of mesuring');
ylabel ('value of alpha');
title ('alpha');
    drawnow;
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%
                    time=toc(tic_a);
                    steps=steps+1;%counter

                    
                end
            end
        end
    end
end

finish_session()