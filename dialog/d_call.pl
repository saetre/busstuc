%% FILE: d_call.pl
%% SYSTEM BUSTER
%% CREATED ØF-010101
%% REVISED TA-051017

%% Compiles all of the necessary files.
%% Same function as the file tucbuses.

:-use_module( d_main ).
:-use_module( d_dialogue ).

%% :-compile(frames).
:-use_module( frames2 ). %% Common version %% TA-051017 %% RS-111204

:-use_module( newcontext2, [] ).
:-compile(portraycontext). %% New file %% TA-051005

%% :-compile(grammar). %% split %% TA-050906
:-compile(exegram).

 :-compile(diagram).   %% TA-051011 Common bus tele

%% :-compile(busgram).

:-compile(checkitem2).  %% TA-051010


:-ensure_loaded(relax).


% new files in tele-domain %% CO-VERSION
:-use_module( parseres, [] ).

:-compile(update2).    %% COMMON VERSION
%:-ensure_loaded(makeframe2). %% COMMON VERSION
:-use_module( makeframe2 ). %% COMMON VERSION


:-use_module( usestate2 ).


%%%%%%%% =
