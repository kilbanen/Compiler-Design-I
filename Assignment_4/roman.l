%{
# include "roman.tab.h"
void yerror(char *s);
%}

%%
"I" { yylval = 1; return SYMBOL; }
"V" { yylval = 5; return SYMBOL; }
"X" { yylval = 10; return SYMBOL; }
"L" { yylval = 50; return SYMBOL; }
"C" { yylval = 100; return SYMBOL; }
"D" { yylval = 500; return SYMBOL; }
"M" { yylval = 1000; return SYMBOL; }
\n  { return EOL; }
%%
