%{
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
int yylex();
void yyerror(char *s);
int convertToRoman (int val, char *res, size_t sz);
%}

%token I V X L C D M
%token PLUS MINUS TIMES DIVIDE
%token EOL
%%
calclist: {}
        | calclist expression EOL { if( $2 == 0) printf("Z"); else {char* res = calloc(sizeof(char),1000); convertToRoman($2, res, 1000); printf("%s\n", res);} }
        ;
expression: number
          | expression PLUS expression { $$ = $1 + $3; }
          | expression MINUS expression { $$ = $1 - $3; }
          | expression TIMES expression { $$ = $1 * $3; }
          | expression DIVIDE expression { if($3 != 0) $$ = $1 / $3; }
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

int convertToRoman (int val, char *res, size_t sz) {
  char *huns[] = {"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"};
  char *tens[] = {"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"};
  char *ones[] = {"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"};
  int   size[] = { 0,   1,    2,     3,    2,   1,    2,     3,      4,    2};

  if(val < 0) {
    val *= -1;
    *res++ = '-';
  }

  //  Add 'M' until we drop below 1000.

  while (val >= 1000) {
    if (sz-- < 1) return 0;
    *res++ = 'M';
    val -= 1000;
  }

  // Add each of the correct elements, adjusting as we go.

  if (sz < size[val/100]) return 0;
  sz -= size[val/100];
  strcpy (res, huns[val/100]);
  res += size[val/100];
  val = val % 100;

  if (sz < size[val/10]) return 0;
  sz -= size[val/10];
  strcpy (res, tens[val/10]);
  res += size[val/10];
  val = val % 10;

  if (sz < size[val]) return 0;
  sz -= size[val];
  strcpy (res, ones[val]);
  res += size[val];

  // Finish string off.

  if (sz < 1) return 0;
  *res = '\0';
  return 1;
}
