# Task 4: synchronize async work using actor

## Functionality Description
App displays starting ballance 1000. As soon as user presses "Start" it decreases this ballance by 1 through 1000 parrallel tasks. When all operations are completed, final ballance is displayed and button swithces to "Reset" mode, which allows to start from the beginning. When you press "Start" button, most likely you won't receive correct answer "0" for final ballance (you might need to repeat couple of times) due to race conditions in Task4ViewAPI.
  

## Task to complete:
Fix that behaviour using actor in a way decrement can still run in parallel tasks, but race conditions are excluded by actor usage. You should consistently receive "0" as answer.  
