%{
#include<stdio.h>
#include<math.h>

int flag=0;
int flag1=0;
%}

%union {
   double dval;
}

%token<dval> NUMBER
%token EXP_OP
%token ADD_OP SUB_OP
%token MUL_OP DIV_OP
%token '(' ')'
%type<dval> E

%left '+' '-'
%left '*' '/'
%right '^'
%left NEG

%%

start: statement '\n' | start statement '\n';

statement: E { if(flag1==0) printf("Answer=%g\n", $1); };

E: NUMBER {$$ = $1; }
  | E '+' E {$$ = $1 + $3; }
  | E '-' E {$$ = $1 - $3; }
  | E '*' E {$$ = $1 * $3; }
  | E '/' E { if($3 == 0) { flag1 = 1; yyerror("Division by zero"); } else $$ = $1 / $3; }
  | E '^' E {$$ = pow($1, $3); }
  | '-' E %prec NEG {$$ = -$2; }
  | '(' E ')' {$$ = $2; }
  | E EXP_OP E {$$ = pow($1, $3); }
  ;

%%

int main() {
    printf("\nEnter Any Arithmetic Expression which can have operations Addition, Subtraction, Multiplication:\n");
    flag1 = 0;
    yyparse();
    if(flag==0)
        printf("\nEntered arithmetic expression is Valid\n\n");
    return 0;
}

int yyerror(const char *s) {
    printf("\nError: %s\n", s);
    flag=1;
    return 0;
}
