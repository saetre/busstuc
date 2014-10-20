%% FILE compile_busstuc.pl
%% SYSTEM BUSSTUC
%% CREATED TA-040615
%% REVISED TA-040617

% Compiles the BussTUC system for NTNU server and AtB.

?-use_module( library(file_systems), [ current_directory/2 ] ).

?-compile( '../busstuc' ).
%% :-user:use_module( '../main', [ jettyrun/1, webrun_norsk/0 ] ).  %% RS-140331 Moved (back?) to tucbuss.pl
?-save_program('../busestuc4').

%?-halt.
% OR
%?-current_directory( _D,'..' ). %% C:/eclipse/workspace/busstuc/compile

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
   
