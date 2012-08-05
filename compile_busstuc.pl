%% FILE compile_busstuc.pl
%% SYSTEM BUSSTUC
%% CREATED TA-040615
%% REVISED TA-110208  FARA

% Compiles the BussTUC system for NTNU server.

?-compile('busstuc.pl'),
  save_program('busestuc', 'webrun_norsk'), %% TA-110208
  halt.


/*   COMPILE FILE OVERVIEW


 create_busstuc  (Unix command)

 
     compile_busstuc.pl

        busstuc.pl
 
           tucbuss.pl

               tucbuses.pl

                   declare.pl
                   utility/...pl
                                    (sicstuc.pl)
                   tuc/....pl
                   tuc/gram_n.pl
                   tuc/gram_e.pl
                      ?-compile_english.                  
                      ?-compile_norsk.
               main.pl

               monobus.pl

                   app/...pl
                   database/...pl

           busroute.pl
 
*/
   
