%{
#include "validar.tab.h"
%}
%%
[0-1]+ { 
    yylval = atoi(yytext); 
    return BOOLEAN; 
}
"AND" { return AND; }
"OR" { return OR; }
"NOT" { return NOT; }
[()] { return yytext[0]; }
[\n] { return '\n'; }
[ \t] ; // Ignorar espacios y tabulaciones
. { 
    printf("Caracter no reconocido: '%s'\n", yytext);
    return yytext[0]; 
}
%%