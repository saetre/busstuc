
debugroute:-

% Example contraints
 
   Station=dragvoll,
   Delay=0,
   Day = saturday,
   Bus=9,

passes1(Route,Station,Delay),
departureday(X,Route,Time,Day),
route(X,Bus,_),

write((Route,X,Station,Delay,Time,Day)),nl,
fail.



