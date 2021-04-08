%{
# include "roman.tab.h"
void yerror(char *s);
%}

%%
"I"  { yylval = 1; return SYMBOL; }
"IV" { yylval = 4; return SYMBOL; }
"V"  { yylval = 5; return SYMBOL; }
"IX" { yylval = 9; return SYMBOL; }
"X"  { yylval = 10; return SYMBOL; }
"L"  { yylval = 50; return SYMBOL; }
"XL" { yylval = 40; return SYMBOL; }
"XC" { yylval = 90; return SYMBOL; }
"C"  { yylval = 100; return SYMBOL; }
"CD" { yylval = 400; return SYMBOL; }
"D"  { yylval = 500; return SYMBOL; }
"CM" { yylval = 900; return SYMBOL; }
"M"  { yylval = 1000; return SYMBOL; }
\n   { return EOL; }
%%
