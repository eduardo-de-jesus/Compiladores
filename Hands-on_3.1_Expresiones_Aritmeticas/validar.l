%{
#include "validar.tab.h"
%}
%%
[0-9]+ { 
    yylval = atoi(yytext); 
    return NUMBER; 
}
[+\-*/()] { return yytext[0]; }
[\n] { return '\n'; }
[ \t] ; // Ignorar espacios y tabulaciones
. { 
    printf("Caracter no reconocido: '%s'\n", yytext);
    return yytext[0]; 
}
%%