%{
%}

%%

"%"          {printf("%%");}
\"(.|\n)*\"  {printf(yytext);}
\*\*.*       {}
\{[^\}]*\}   {}
.|\n         {printf(yytext);}

%%

int main()
{
  yylex();
  return 0;
}
