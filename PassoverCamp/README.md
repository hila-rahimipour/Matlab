**GeneralCodeStage3.m**
  The code is based on the file stage2.m
  The code create a rectangle on a matrix and displays it over a matlab plot. 
  When running the code, the computer needs to be connected to an EEG device. The code recieves the brain signals from the device. Once the alpha waves value reaches
  its threshold, the rectangle will move to the right. The program will stop running when the rectangle reaches the right side.
  
 
**GeneralCode5.m**
  The code is based on the file stage4.m
  The code creats 3 dimentional metrix in order to create an RGB color displayed on the screen (the initial color is red). 
  When running the code, the computer needs to be connected to an EEG device. The code recieves the brain signals from the device. Once the avarage alpha waves values reach its threshold, the color will slowly transfer to a green color. Once the alpha values are below the threshold, the color will slowly transfer back to a red color.


**projectgeneralcode.m**
  When running the code, the computer needs to be connected to an EEG device and to an Arduino device. The code recieves the brain signals from the device.
  Once the alpha waves values are above the threshold and the beta waves values are below the threshold, 2 red LED's and 1 yellow LED will blink and a loud music will be played. Once the alpha values are below the threshold and the beta values are above the threshold, a blue LED will light up and a calm music will be played. Else, a white LED will light up and the user will be able to press a button in order to make all the LED's blink and play the song "Never gonna give you up" by Rick Astley.


**projectgeneralcodeavg.m**
   When running the code, the computer needs to be connected to an EEG device and to an Arduino device. The code recieves the brain signals from the device.
   Once the avarage alpha waves values are above the threshold, 2 red LED's and 1 yellow LED will blink and a loud music will be played. Once the avarage alpha values are below the threshold, a blue LED will light up and a calm music will be played. Else, a white LED will light up and the user will be able to press a button in order to make all the LED's blink and play the song "Never gonna give you up" by Rick Astley.
