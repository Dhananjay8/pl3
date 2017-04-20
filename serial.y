%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
extern FILE *yyin;
%}

%token INTEGER
%left '+' '-'
%left '*' '/'
%left '(' ')'

%%

printer: E {printf("\nResult = %d\n",$$);
            return 0;
	   }
E:
INTEGER	{ $$ = $1; }
|E'+'E  { $$ = $1 + $3;}
|E'-'E  { $$ = $1 - $3;}
|E'*'E  { $$ = $1 * $3;}
|E'/'E  { $$ = $1 / $3;} 
|'('E')'{ $$ = $2;}
;
%%

void yyerror(char *s) 
{
	fprintf(stderr, "%s\n", s);
	
}
int main(int argc, char *argv[])
{
	printf("\n********** CALCULATOR **********");
	FILE *fh;
	fh = fopen("inputfile.txt","r");
	yyin = fh;
	for(int i=0; i<10; i++)
	{
		yyparse();
	}
	fclose(yyin);
	return 0;
}
