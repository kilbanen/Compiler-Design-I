%{
int evens = 0;
%}

%%

[0-9]*[24680][ \n]  { evens++; }
.|\n                {}

%%

int main()
{
  yylex();
  printf("%d\n", evens);
  return 0;
}
