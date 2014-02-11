%% FILE slash.pl
%% SYSTEM TUC
%% CREATED TA-921106
%% REVISED TA-081110

%Defines (through translat.pl):
%            ( def )/1,

:-module(slash, [
        def/1
]).

%%% RS-111205, UNIT: /
:- ensure_loaded( user:'../declare' ).

%%% RS-111205, UNIT: app/
:- use_module( '../app/busanshp', [ description/2 ] ).          %% RS-131225

%%% RS-111205, UNIT: /tuc/
:- use_module( facts, [ have/4 ]). %% RS-131225
:- use_module( semantic, [ iv_templ/2, tv_templ/3 ]).    %  TUCs  Lexical Semantic Knowledge Base
:- use_module( evaluate, [ fact/1, fakt/1, valof/2 ] ).          %% RS-131225
:- use_module( world0, [ borders/2, containsX/4 ] ).          %% RS-131225

%% RS-131225    UNIT: utility/
%:- ensure_loaded( '../utility/utility' ). %%, [ out/1 ]). %%RS-131224

%% Definition of facts / 
%% Not removed by reset
%% 
%% Also with extensions in other files 

% standards

% event/real/Var  only 1 solution ! %

def event/real/_ :-!.            %% TA-971122 ...

% def event/real/free(_):-!.
% def event/real/real:-!.        %% One situation exists  %% TA-971106

% def event/real/be1(_):-!.      %% TA-971106
% def event/real/flows(_):-!.    %% TA-971106

def exist/_X/_S .

def equal/X/X/_ .  

def be1/X/be1(X). 

def be2/X/X/_S .    %% something has a situation dependent value

def equal/X/X. 

def unequal/X/Y:-
    dif(X,Y).  

def identity/eq/X/Y :-
    X=Y.

def identity/ne/X/Y :-
    dif(X,Y).


def srel/in/time/X/Y :-   %% TA-980619
    fakt(srel/P/time/X/Y),
    member(P,[in,at,on]).

def srel/in/place/X/Y :-  %% TA-980619
    fakt(srel/P/place/X/Y),
    member(P,[in,at,on]).

def write/tuc/A/_ :- user:out(A).  %% TA-971218         From xxx.pl?
%%%%%% Prototypical external connection %%%%%%

def flow/R/flows(R). 

def run/R/flows(R).  %% run is synonymous with flow for rivers (only)
    
def srel/after/C/Year1/S :-  
    fact(srel/in/C/Year2/S),
    def number/lt/Year1/Year2.    

def srel/before/C/Year2/S :-  
    fact(srel/in/C/Year1/S),
    def number/lt/Year1/Year2.

%def srel/from/_/C/flows(R):- 
%    flows_outfrom(R,C).    %% rivers.pl  

def srel/in/place/E/be1(B) :- %%  UGLY AND AD HOC
    def nrel/in/country/continent/B/E .

def srel/in/country/N/be1(O) :-
    def nrel/in/city/country/O/N .


def nrel/in/_/world/_/earth :- !. %% TA-980428

def nrel/in/Country/Continent/Norway/Europe :- 
    containsX(Continent,Country,Europe,Norway). %% world0.pl


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% All slash facts preceded by def 

%Based on world0.pl Database (missing!)
%def african/X/_ :-
%    african(X).
%
%def american/X/_ :- 
%    american(X).
%
%def asian/X/_ :-
%    asian(X).
%
%def australian/X/_ :-
%    australian(X).
%
%def european/X/_ :-
%    european(X).

def describe/tuc/X/_ :- 
    description(X,Y),    %% turbo.pl
    user:out(Y).

def exceed/X/Y/_ :-
    valof(X,X1),    %% evaluate.pl
    valof(Y,Y1),
    !,
    number(X1),
    number(Y1),
    X1 > Y1 .

def border/X/Y/_ :- 
    borders(X,Y).    %% border.pl


def has/C/A/X/Y :-  
    have(C,A,X,Y). %% facts.pl


def intransitive/V/_:-
    iv_templ(V,_).

def knowthing/John/K/S :-                                  
    fact(know/id/that/John/K/S).  

def list/tuc/X/_ :- user:out(X).
def give/tuc/X/_ :- user:out(X).
def show/tuc/X/_ :- user:out(X).

%% def srel/to/person/ I /_  :- !. %% TA-081110 
                         


   %% EXECUTED during TEST !

def time/in/X/X .

def time/after/X/Y:-
    number(X),
    number(Y),
    X > Y .

def time/before/X/Y:-
    number(X),
    number(Y),
    X < Y .

def time/when/X/Y:-
    number(X),
    number(Y),
    X = Y .

def transitive/V/_:-
    tv_templ(V,_,_).

def number/gt/X/Y :-    
    def number/lt/Y/X.

def number/ge/X/Y :-    
     def number/le/Y/X.

def number/lt/X/Y :-    
    number(X),
    number(Y),
    X < Y .

def number/le/X/Y :-     
    number(X),
    number(Y),
    X =< Y.

def number/eq/X/Y :-     
    number(X),
    number(Y),
    X = Y .

def number/ne/X/Y :-     
    number(X),
    number(Y),
    \+ (X=Y).

def place/in/X/X .

%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

