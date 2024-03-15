%{
#include<stdio.h>
#include "y.tab.h"
%}

digit [0-9]
expop \^
ws [ \t\n]
%%
{digit}+(\.{digit}+)? {
    yylval.dval = atof(yytext);
    return NUMBER;
}
{expop} {
    return EXP_OP;
}
[-+*/()\n] return *yytext;
{ws}  ; /* skip whitespace */
. yyerror("Invalid character");
%%

int yywrap() {
    return 1;
}
