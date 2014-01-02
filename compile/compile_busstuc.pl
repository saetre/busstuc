%% FILE compile_busstuc.pl
%% SYSTEM BUSSTUC
%% CREATED  TA-040615    %% REVISED TA-110208  FARA
%% REVISED  RS-140101 modularized

% Compiles the BussTUC system for NTNU server.

?-compile('../busstuc.pl').
?-save_program('busestuc', 'webrun_norsk'). %% TA-110208 %% RS-120805   %% Autostart webrun-predicate on load
?-halt.

/*   COMPILE FILE OVERVIEW
 create_busstuc  (Unix command)
     compile_busstuc.pl
        busstuc.pl
           tucbuss.pl
               tucbuses.pl
                   user:declare.pl      (in module user:)
                   utility/ *.pl
                                   (sicstuc.pl)
                   tuc/ *.pl
                   tuc/gram_n.pl
                   tuc/gram_e.pl
                      ?-compile_english.                  
                      ?-compile_norsk.
               main.pl        %% RS-140101
               monobus.pl
                   app/...pl
                   database/...pl
           busroute.pl
*/
   
