%{
# include <stdio.h>
int yylex();
void yyerror(char *s);
%}

%token SYMBOL
%token EOL
%%
calclist: {}
        | calclist number EOL { printf("%d\n", $2); }
        ;
number: SYMBOL
      | SYMBOL SYMBOL { $$ = $1 + $2; }
      | SYMBOL SYMBOL SYMBOL { $$ = $1 + $2 + $3; }
      ;
%%

int main()
{
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}