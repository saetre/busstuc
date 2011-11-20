%% FILE inconstations.pl

%% Detect inconsistencier in station identifiers

crerr:-

  set_of(X, (reference(X), \+ hpl(_,X,_Off)),

      Z),

  for(member(Y,Z),(write(Y),nl)).

reference(X):- 
    (placestat(_,X)
           ;
    cmpl(_,_,X))
     ;
    isat(X,_).





    
