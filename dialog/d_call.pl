/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE: d_call.pl
%% SYSTEM BUSTER
%% CREATED ØF-010101
%% REVISED TA-051017

%% Compiles all of the necessary files.
%% Same function as the file tucbuses.

:-compile(d_main).
:-compile(d_dialogue).

 :-compile(frames2). %% Common version %% TA-051017

%% :-compile(frames).
:-compile(newcontext2).
:-compile(portraycontext). %% New file %% TA-051005

%% :-compile(grammar). %% split %% TA-050906
:-compile(exegram).

 :-compile(diagram).   %% TA-051011 Common bus tele

%% :-compile(busgram).

:-compile(checkitem2).  %% TA-051010


:-compile(relax).


% new files in tele-domain %% CO-VERSION
:-compile(parseres).

:-compile(update2).    %% COMMON VERSION
:-compile(makeframe2). %% COMMON VERSION


:-compile(usestate2).


%%%%%%%% =
