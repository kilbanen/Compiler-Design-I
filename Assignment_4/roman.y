%{
# include <stdio.h>
# include <stdlib.h>
int yylex();
void yyerror(char *s);
%}

%token I V X L C D M
%token EOL
%%
calclist: {}
        | calclist number EOL { printf("%d\n", $2); }
        ;
is: I
  | I I { $$ = $1 + $2; }
  | I I I { $$ = $1 + $2 + $3; }
  ;
units: is
     | I V { $$ = $2 - $1; }
     | V
     | V is { $$ = $1 + $2; }
     | I X { $$ = $2 - $1; }
     ;
xs: X
  | X X { $$ = $1 + $2; }
  | X X X { $$ = $1 + $2 + $3; }
  ;
tens: xs
     | X L { $$ = $2 - $1; }
     | L
     | L xs { $$ = $1 + $2; }
     | X C { $$ = $2 - $1; }
     ;
cs: C
  | C C { $$ = $1 + $2; }
  | C C C { $$ = $1 + $2 + $3; }
  ;
hundreds: cs
        | C D { $$ = $2 - $1; }
        | D
        | D cs { $$ = $1 + $2; }
        | C M { $$ = $2 - $1; }
        ;
ms: M
  | M M { $$ = $1 + $2; }
  | M M M { $$ = $1 + $2 + $3; }
  ;
number: units
      | tens
      | tens units { $$ = $1 + $2; }
      | hundreds
      | hundreds units { $$ = $1 + $2; }
      | hundreds tens { $$ = $1 + $2; }
      | hundreds tens units { $$ = $1 + $2 + $3; }
      | ms
      | ms units { $$ = $1 + $2; }
      | ms tens { $$ = $1 + $2; }
      | ms tens units { $$ = $1 + $2 + $3; }
      | ms hundreds { $$ = $1 + $2; }
      | ms hundreds units { $$ = $1 + $2 + $3; }
      | ms hundreds tens { $$ = $1 + $2 + $3; }
      | ms hundreds tens units { $$ = $1 + $2 + $3 + $4; }
      ;
%%

int main()
{
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "%s\n", s);
  exit(0);
}
