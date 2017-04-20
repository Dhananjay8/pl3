%{
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#define YYSTYPE int
int expert = 2, nothreads = 5;
%}

%token INTEGER
%left '+' '-'
%left '*' '/'
%left '(' ')'

%pure-parser
%lex-param {void *scanner}
%parse-param {void *scanner}


%%
printer: E 	
		{
			return $$;
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

void solver()
{
	void *scanner;
	yylex_init(&scanner);
	int tid, result, i, j;
	FILE *fh;
	fh = fopen("inputfile.txt","r");
	/*if file doesn't exist*/
	if(!fh)
	{
		printf("\nNo such file exists");
		exit(0);
	}

	tid = omp_get_thread_num();
	char *buf = malloc(100); 
	size_t siz = 100; 
	for(i=0; i<(expert*tid); i++)
	{
		getline(&buf,&siz,fh);		
	}
	yyset_in(fh,scanner); 
	for(j=0; j<expert; j++)
	{
		result = yyparse(scanner);
		printf("\nExpression = %d --> Thread = %d : Result = %d\n",(expert*tid+j+1),tid,result);
	}
	yylex_destroy(scanner);
	fclose(fh);
}

/*main*/
void main()
{
	#pragma omp parallel num_threads(nothreads)
	{
		solver();
	}
}

/*error function*/
int yyerror() 
{
	printf("\nInvalid!");
}


/*
hp@hp/Desktop/Final Codes/4$ cc y.tab.c lex.yy.c
hp@hp/Desktop/Final Codes/4$ lex omp.l
hp@hp/Desktop/Final Codes/4$ yacc -d omp.y
hp@hp/Desktop/Final Codes/4$ cc y.tab.c lex.yy.c -fopenmp
*/
