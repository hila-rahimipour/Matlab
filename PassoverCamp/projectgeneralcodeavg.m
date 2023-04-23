% this script is a general script of neurofeedback using emotiv 
clear
%%  INPUT PARAMETERS
% Choose the channel's number:
CHANNEL= 11
% LIST OF CHANNELS AND NUMBERS:
% 4 - AF3 % 5 - F7 % 6 - F3 % 7 - FC5 % 8 - T7 % 9 - P7 % 10 - O1
% 11 - O2 %12 - P8 %13 - T8 %14 - FC6 %15 - F4 %16 - F8 %17 - AF4

% Choose the length of the BCI session, in seconds:
runtime = 520;



%% Initialize emotiv, do not make changes here
init_emotiv()


%% This is the feedback loop
disp([ 'feedback is for channel:' channelName{CHANNEL}] )
%steps=1;%counter
tic_a= tic;
steps=1;
%% YOUR CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
betatetavec = [];
alphavec=[];
gammavec=[];
thresholdA = 3.5;
minA = 2;
thresholdBT=1.5;
thresholdG =0.6 ;
a = arduino('com3', 'uno');
PO = 0;
FO=0;
ZO=0;
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
                    %% YOUR CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    % D3 IS BLUE LIGHT. D4 IS WHITE. D6 IS RED, D5 IS ORANGE.
                    alphavec=[alphavec, alpha];
                    betatetavec=[betatetavec, lowBeta/theta];
                    gammavec = [gammavec, gamma];
                    if length(alphavec) > 4 & length(betatetavec) > 4  & length(gammavec) > 4
                     
                        avgA = mean(alphavec(length(alphavec)-4:length(alphavec)));
                        avgBT = mean(betatetavec(length(betatetavec)-4:length(betatetavec)));
                        avgG = mean(gammavec(length(gammavec)-4:length(gammavec)));
                    if avgA > thresholdA 
                      try
                        stop(FO)
                        FO=0;
                       
                        catch
                        end 
                        try
                            stop(ZO)
                        ZO=0;
                        catch
                        end
                        writeDigitalPin(a, 'D3', 0);
                        writeDigitalPin(a, 'D4', 0);
                        writeDigitalPin(a, 'D6',1);
                        writeDigitalPin(a, 'D5', 1);                      
                        pause(0.025);
                        writeDigitalPin(a, 'D6',0);
                        writeDigitalPin(a, 'D5', 0);                        
                        pause(0.025);
                        writeDigitalPin(a, 'D3', 0);
                        writeDigitalPin(a, 'D4', 0);
                        writeDigitalPin(a, 'D6',1);
                        writeDigitalPin(a, 'D5', 1);
                        if PO==0
                        [y, Fs] = audioread("D:\BCI - ARIEL AND YONATAN/wakeup.mp3");
                        PO = audioplayer(y, Fs);
                        play(PO);
                        
                        end
                        %increase value
                    elseif  avgA < minA
                        try
                        stop(PO)
                        PO=0;
                       
                        catch
                        end 
                        try
                            stop(FO)
                        FO=0;
                        catch
                        end
                        writeDigitalPin(a, 'D6',0);
                        writeDigitalPin(a, 'D5', 0);
                        writeDigitalPin(a, 'D4', 0);
                        writeDigitalPin(a, 'D3', 1);
                        if ZO==0
                        [z, Fz] = audioread("D:\BCI - ARIEL AND YONATAN/relax.mp3");
                        ZO = audioplayer(z, Fz);
                        play(ZO);
                        
                        end
                        
                    else
                       try
                        stop(PO)
                        PO=0;
                       
                        catch
                        end 
                        try
                            stop(ZO)
                        ZO=0;
                        catch
                        end
                        
                        writeDigitalPin(a, 'D6',0);
                        writeDigitalPin(a, 'D5', 0);
                        writeDigitalPin(a, 'D3', 0);
                        writeDigitalPin(a, 'D4', 1);
            if readDigitalPin(a, 'D2')==1 & FO==0
                
                [x, Fx] = audioread("D:\BCI - ARIEL AND YONATAN/Rick.mp3");
                FO = audioplayer(x, Fx);
                play(FO);
                pause(0.15);
                while(readDigitalPin(a, 'D2')==0)
                    writeDigitalPin(a, 'D5', 0);
                    writeDigitalPin(a, 'D3', 1);
                    writeDigitalPin(a, 'D4', 1);
                    writeDigitalPin(a, 'D6', 1);
                    pause(0.1);
                    writeDigitalPin(a, 'D3', 0);
                    writeDigitalPin(a, 'D6', 1);
                    pause(0.1);
                    writeDigitalPin(a, 'D4', 0);
                    writeDigitalPin(a, 'D5', 1);
                    pause(0.1);
                    writeDigitalPin(a, 'D6', 0);
                    writeDigitalPin(a, 'D3', 1);
                    pause(0.1);
                    
                    
                end
                stop(FO);
                writeDigitalPin(a, 'D4', 1);
                writeDigitalPin(a, 'D6',0);
            writeDigitalPin(a, 'D5', 0);
            writeDigitalPin(a, 'D3', 0);
            end
        end
                  end 
                    
               
                    
                        
                   
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