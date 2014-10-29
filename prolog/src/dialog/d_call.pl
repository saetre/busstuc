/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE: d_call.pl
%% SYSTEM BUSTER
%% CREATED ØF-010101
%% REVISED TA-051017

%% Compiles all of the necessary files. (in user: NOT a module)
%% Same function as the file tucbuses. (Called from tucbuster.pl)

%:- compile(d_main).            %% RS-141002 Changed to modules!
:- use_module( d_main, [ ] ). % Import ALL?  %% RS-140914
%:- compile(d_dialogue).        %% RS-141002 Changed to modules!
:- use_module( d_dialogue, [ ] ). % Import ALL?

% :-compile(frames2). %% Common version %% TA-051017 %% :-compile(frames). %% OLD
:- use_module( frames2, [ ] ). %% Common version %% TA-051017

%:-compile(newcontext2).        %% RS-141002 Changed to modules!
:- use_module( newcontext2, [ ] ). %% Import ALL?
:- use_module( portraycontext, [ ] ). %% New file %% TA-051005

%% :-compile(grammar). %% split %% TA-050906
%% :-compile(busgram).
%:-compile(exegram).           %% RS-140210      create_splitacts/2, etc.? %% RS-141002 Changed to modules!
:- use_module( exegram,  [ ] ). % Import ALL?          %% RS-140210      create_splitacts/2, etc.?

%:-compile(diagram).   %% TA-051011 Common bus tele
:- use_module( diagram, [ ] ).   %% TA-051011 Common bus tele


% :- compile(checkitem2).  %% TA-051010
:-use_module( checkitem2, [ ] ).  %% RS-140211

:-use_module( relax, [] ).

% new files in tele-domain %% CO-VERSION
:-use_module( parseres, [] ). %%compile?!?

%:-compile(update2).    %% COMMON VERSION
:- use_module( update2, [ ] ).    %% COMMON VERSION
:- use_module( makeframe2, [ ] ). % rule/2 %% COMMON VERSION     %% RS-130624 use_module (many files all contains    rule    predicates, don't import here? )

:-use_module( usestate2, [] ).


%%%%%%%% = 46
