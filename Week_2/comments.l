%{
%}

%%

"%"          {printf("%%");}
\"(.|\n)*\"  {printf(yytext);}
\*\*.*       {}
\{[^\}]*\}   {}
\{[^\}]*     {printf("syntax error");}
\}(.|\n)*    {printf("syntax error");}
.|\n         {printf(yytext);}

%%

int main()
{
  yylex();
  return 0;
}
