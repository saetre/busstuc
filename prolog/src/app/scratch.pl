%% This is just a TEMPFILE for

%% the main connection predicate
%% between two depnodes
%% Extended to capture cutloop stations

iscorr3x(Orig,Dest,StartDep,EndDep,Mid):- 

    StartDep = depnode(_OrigTime0,OrigTime9,_DelArr1,DelDep1,BegTime1,Rid1,_),
    EndDep   = depnode(DestTime0,_DestTime9,DelArr2,_DelDep2,BegTime2,Rid2,_),

    Mid = [OffTime,OStation,OnTime,OStation],

    passeq(Rid1,Orig,SeqA1,_,DelDep1),
    passeq(Rid1,OStation,SeqA2,OffDelay,_),

    SeqA1 < SeqA2,

	 addtotime(BegTime1,OffDelay,OffTime),       % Compute OffTime
    OffTime >= OrigTime9,    % Check OffTime consistent


    passeq(RidX,OStation,_,_,      OnDelay),

    addtotime(BegTime2,OnDelay,OnTime),         % Enter Time Bus 2
    OnTime =< DestTime0,     % Check Less Dest Time 

    compute_delay_margin(Rid1,Rid2,Margin),     % Minimal delay from off to on
	 addtotime(OffTime,Margin,ReadyToEnterTime), %	

    OnTime>=ReadyToEnterTime,                   % Check Time to change

    cutloop_connected_rids(Rid2,CutLoop,RidX), 
 
    passeq(RidX,CutLoop, 1,_,_), % = 1. from CutLoop
    passeq(RidX,Dest,    _SeqC2,  DelArr2,_),

 

    addtotime(OffTime,60,DiedWaiting), 
    OnTime < DiedWaiting.              
  
