%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
%}

COUNTY C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|TN|TS|W|WD|WH|WX|WW
OLD_YEAR [0-9]{2}
NEW_YEAR [0-9]{2}(1|2)
NUMBER [1-9][0-9]{0,5}
INVALID_NUMBER [0-9]{7,}

%%
({OLD_YEAR}|{NEW_YEAR})- {printf("INVALID\n");}
{OLD_YEAR}-T-{NUMBER} {printf("INVALID\n");}
{NEW_YEAR}-(LK|TN|TS|WD)-{NUMBER} {printf("INVALID\n");}
({OLD_YEAR}|{NEW_YEAR})-{COUNTY}-{INVALID_NUMBER} {printf("INVALID\n");}
({OLD_YEAR}|{NEW_YEAR})-[a-z]-{NUMBER} {printf("INVALID\n");}
({OLD_YEAR}|{NEW_YEAR})-{COUNTY}-{NUMBER} {
  char year[3];
  strncpy(year, yytext, 2);
  int yearint = atoi(year);
  if(yearint > 21) yearint -= 100;
  printf("%d\n",21 - yearint);
}
.|\n                {}

%%

int main()
{
  yylex();
  return 0;
}
