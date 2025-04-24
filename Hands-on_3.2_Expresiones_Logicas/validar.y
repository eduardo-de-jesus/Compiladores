%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
int yyerror(char *s);
%}
%token AND OR NOT BOOLEAN
%start input

%%
input: expr '\n' { printf("Expresión válida\n\n"); }
     | error '\n' { yyerror("Expresión inválida\n"); yyerrok; }
     | input expr '\n' { printf("Expresión válida\n\n"); }
     | input error '\n' { yyerror("Expresión inválida\n"); yyerrok; }
     ;
expr: expr AND term { printf("AND: %d AND %d\n", $1, $3); $$ = $1 && $3; }
    | expr OR term { printf("OR: %d OR %d\n", $1, $3); $$ = $1 || $3; }
    | term;

term: NOT factor { printf("NOT: NOT %d\n", $2); $$ = !$2; }
    | factor;

factor: '(' expr ')' { $$ = $2; }
      | BOOLEAN { $$ = $1; };

%%
int yyerror(char *s) {
    fprintf(stderr, "Error de sintaxis: %s\n", s);
    return 0;
}

int main() {
    printf("VALIDAR EXPRESIONES LOGICAS\n");
    yyparse();
    return 0;
}