/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE: d_call.pl
%% SYSTEM BUSTER
%% CREATED ØF-010101
%% REVISED TA-051017

%% Compiles all of the necessary files.
%% Same function as the file tucbuses.

:-compile(d_main).
:-compile(d_dialogue).

% :-compile(frames2). %% Common version %% TA-051017
:-use_module( frames2, [ ] ). %% Common version %% TA-051017
%% :-compile(frames).

%:-compile(newcontext2).
:-use_module(newcontext2).
:-compile(portraycontext). %% New file %% TA-051005

%% :-compile(grammar). %% split %% TA-050906
:-compile(exegram).           %% RS-140210      create_splitacts/2, etc.?
%:-ensure_loaded( exegram ).      %% create_splitacts/2, etc.?

:-compile(diagram).   %% TA-051011 Common bus tele

%% :-compile(busgram).

%:-compile(checkitem2).  %% TA-051010
:-use_module( checkitem2, [ ] ).  %% RS-140211


:-use_module(relax).


% new files in tele-domain %% CO-VERSION
:-use_module(parseres). %%compile?!?

:-compile(update2).    %% COMMON VERSION
:-use_module(makeframe2). %% COMMON VERSION     %% RS-130624 use_module (many files all contains    rule    predicates )


:-use_module(usestate2).


%%%%%%%% =
