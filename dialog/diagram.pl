%% FILE diagram.pl
%% SYSTEM BUSTER
%% CREATED TA-051010
%% REVISED TA-051011

/* Referred to from d_dialog
tb_start2
tb_from
*/


%% Common Dialog Grammar for bus and tele


% Dialog := UserQs
gram(dialog, [
        [sub(userQs), item(dialogerror), sub(dialog)]
        ],
        []).

% UserQs := UserQ UserQs
%         | []
gram(userQs, [
        [sub(userQ), sub(userQs)],
        []
        ],
        []).

% UserQ := uiq, UiqRepl
%        | uin, UiqRepl %% TA-050719 (was UinRepl)
%        | []
gram(userQ, [
        [item(uin), sub(uiqRepl)],
        [item(uiq), sub(uiqRepl)]
        ],
        []).

% UiqRepl := sant
%          | Askrefs, Askfors, UiqRepl2
gram(uiqRepl, [
        [item(sant)],
        [sub(askrefs), sub(askfors), sub(uiqRepl2)]
        ],
        []).

% UiqRepl2 := sat, modify
%          | saf
gram(uiqRepl2, [
        [item(sat), sub(modify)],
        [item(sal), sub(modify)],   %% TLF 030505
    [item(relax), item(sat), sub(modify)], %% suspended ? %% TA-060705
        [item(saf)]
        ],
        []).


% Askrefs := Askref Askrefs
%          | []
gram(askrefs, [
        [sub(askref), sub(askrefs)],
        []
        ],
        [queryUp]).

% Askref := sqd, SqdRepl
gram(askref, [
        [item(sqd), sub(sqdRepl)]
        ],
        [queryUp]).

% SqdRepl := uadi
%         | uadm
%         | uadn
%         | uadq
gram(sqdRepl,[
        [item(uadi)],
        [item(uadm)],
        [item(uadn)],
        [item(uadq)]
        ],
        [queryUp]).


% Askfors := Askfor Askfors
%          | []
gram(askfors, [
        [sub(askfor), sub(askfors)],
        []
        ],
        []).

% Askfor := sqt, UserQs, SqtRepl
gram(askfor, [
        [item(sqt), sub(userQs), sub(sqtRepl)]
        ],
        []).

% SqtRepl := uati
%         | uatm
%         | uatn
%	  | uatg
gram(sqtRepl,[
        [item(uati)],
        [item(uatc)],    %% TLF-030530
        [item(uatm)],
        [item(uatn)],
        [item(uatg)],
	     [item(uatf)]
        ],
        []).

% Modify := uim, UiqRepl
%         | []
gram(modify,[
        [item(uim), sub(uiqRepl)],
        []
        ],
        []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Tb_start := tbs_welcomegreeting, tbs_welcomequestion, Tb_start2 
%        | []
gram(tb_start, [
	[item(say(tbs_welcomegreeting)), item(sayq(tbs_welcomequestion)), sub(tb_start2)],
	[]
	],
	[]).

% Tb_start2 := no, tbs_userhelp, Tb_from
%            | yes, Tb_from
%            | []
gram(tb_start2, [
	[item(no), item(say(tbs_userhelp)), sub(tb_from)],
	[item(yes), sub(tb_from)],
	[]
	],
	[]).

% Tb_from := tbs_fromwhere, Tb_from2
%          | []
gram(tb_from, [
	[item(tbs_fromwhere), sub(tb_from2)],
	[]
	],
	[]).


gram(reset_dialog, [  %% TA-030113 %% EXPERIMENTAL

   [item(nil)]],      %% Dummy

   []).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
