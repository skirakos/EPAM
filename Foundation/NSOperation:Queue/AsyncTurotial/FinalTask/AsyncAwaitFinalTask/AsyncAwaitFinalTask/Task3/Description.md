# Task 3: implement function that returns stream of values

## Functionality Description
View contains label "Current singal strength" and button "Start monitoring". As soon as you press the button it changes its title to "Cancel" and signal strength is updated to some random value defined in `Task3API.SignalStrength` (expect `unknown` value) and process stops. Issue: stream never finishes and `stream finished` is never printed to console. 

## Task to complete:
Rewrite implementation of `Task3API.signalStrength()` function so it can produce new random value each 1 second until user presses "Cancel" button. Make sure that after user presses cancel stream is finished and you can see `stream finished` printed to console
