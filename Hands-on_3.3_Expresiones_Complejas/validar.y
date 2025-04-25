%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
int yyerror(char *s);
%}
%token AND OR NOT BOOLEAN
%left '+' '-'
%left '*' '/'
%start input

%%
input: expr '\n' { printf("Expresión válida\n\n"); }
     | error '\n' { yyerror("Expresión inválida\n"); yyerrok; }
     | input expr '\n' { printf("Expresión válida\n\n"); }
     | input error '\n' { yyerror("Expresión inválida\n"); yyerrok; }
     ;
expr: expr '+' term { printf("Suma: %d + %d\n", $1, $3); $$ = $1 + $3; }
    | expr '-' term { printf("Resta: %d - %d\n", $1, $3); $$ = $1 - $3; }
    | term

term: term '*' factor { printf("Multiplicación: %d * %d\n", $1, $3); $$ = $1 * $3; }
    | term '/' factor { 
        if ($3 == 0) {
            yyerror("División por cero");
            $$ = 0;
        } else {
            printf("División: %d / %d\n", $1, $3); $$ = $1 / $3; 
        }
      }
    | factor;

factor: '(' expr ')' { $$ = $2; }
      | logical ;

logical: logical AND term { printf("AND: %d AND %d\n", $1, $3); $$ = $1 && $3; }
    | logical OR term { printf("OR: %d OR %d\n", $1, $3); $$ = $1 || $3; }
    | NOT factor { printf("NOT: NOT %d\n", $2); $$ = !$2; }
    | BOOLEAN { $$ = $1; };

%%
int yyerror(char *s) {
    fprintf(stderr, "Error de sintaxis: %s\n", s);
    return 0;
}

int main() {
    printf("VALIDAR EXPRESIONES COMPLEJAS\n");
    yyparse();
    return 0;
}