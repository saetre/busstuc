%% FILE exegram.pl
%% SYSTEM BUSTER
%% CREATED TA-050906
%% REVISED TA-050906

%% Dialog Grammar execution 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- use_module( '../main', [ dialog/0 ] ).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

create_splitacts(Acts+B,Acts+B):-!. %% Already done
create_splitacts(Acts,Acts+[]). %% Acts + PrevActs

split_acts( [Act|Racts]+PrevActs, Act,Racts+[Act|PrevActs]).

%% Racts are previous acts in REVERSE  ORDER 

empty_acts( []+_ ).


%% Grammar Execution



g_execute(  [node(Type, ItemType , Focus, Acts)|RestStack], NewStack, Multi) :-

    create_splitacts(Acts,Sacts),
    
    g_execute2( node(Type, ItemType , Focus, Sacts) ,RestStack, NewStack, Multi).


% Select first disjunct that succeds



g_select2(  node(Type, _ ,Focus, Alternatives) , RestStack, NewStack, Multi) :-

    Alternatives = [First|_],
    
    create_splitacts(First,SFirst), 

    g_execute2( node(Type,   _  ,Focus,   SFirst), RestStack, NewStack, Multi), 
    !. %% Comit  first successful  disjunct


g_select2(   node(Type,   _  , Focus, Alternatives) , RestStack, NewStack, Multi) :-

     Alternatives = [_|Rest],

     g_select2( node(Type,   _  , Focus,       Rest) , RestStack, NewStack, Multi).




g_execute2(  node(Type,  _  , Focus, Sacts),  RestStack, NewStack, Multi) :-

    split_acts(Sacts,sub(SubType), RestActs),


    trackprog(3, (write('*** g_execute  '), out(Type),out(':='),out(sub(SubType)))), %% TA-051106

    gram(SubType, Alternatives, _Options), 

%     copydown(Options, Focus, SubFocus), %% TA-050720

    g_select2( node(SubType,  _  , Focus, Alternatives), [node(Type,  _  , Focus, RestActs)| RestStack], 
	          NewStack, Multi).

   
g_execute2(  node(Type, _  , _OldFocus, _Acts),  _RestStack ,_NewStack, _Multi) :-

    Type==reset_dialog,
    !,

    trackprog(3, output('*** g_execute reset_dialog: ')),%% TA-041014
 
    dialog. %% Brutal %% TA-030112 




%%%%
 
   
g_execute2( node(Type,  _  , OldFocus, Sacts),  RestStack,NewStack, Multi) :-

    split_acts(Sacts,item(ItemType), RestActs),


    trackprog(3, (write('*** g_execute  '), out(Type),out(':='),output(item(ItemType)))),

    trackprog(3, (write('call checkitem: '), write(ItemType),nl)), %% TA-041014 

    checkitem(ItemType, OldFocus, NewFocus),

    trackprog(3, (write('checkitem: '), write(ItemType),output(' succeeded. '))), %% TA-041014 

%%%%%%    gram(Type, _, _Options), %% <--- Superfluous %% TA-050721

%%     copyright(Options, NewFocus, NextFocus), %% TA-050720

(    
     (sysout_item(ItemType) ; Multi) ->  

    NewStack = [node(Type, item(ItemType)  , NewFocus, RestActs)| RestStack]   ;

           g_execute2( node(Type,  _  ,NewFocus, RestActs),  RestStack ,  NewStack, Multi) 
                                      
).




g_execute2( node(SubType, _ , SubFocus, Sacts),  OldRestStack, NewStack, Multi) :-
    
    empty_acts(Sacts),  

    OldRestStack = [node(Type, _ItemType , Focus, RestActs)|RestStack],

    trackprog(3, (write('*** g_execute back: '), out(Type),out(':='),out(SubType))), %% TA-051106 

    gram(SubType, _, Options),   

    copyup(Options, SubFocus, Focus, NewFocus),

    g_execute2( node(Type,  _  , NewFocus, RestActs),RestStack , NewStack, Multi).



copyup([],       focus(Frame, Refer, _),    focus(_, _, Query),focus(Frame, Refer, Query)):-!.

copyup([queryUp],focus(Frame, Refer, Query),focus(_, _, _),    focus(Frame, Refer, Query)). 




