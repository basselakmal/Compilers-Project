%{
	#include <stdio.h>
	#include <math.h>
	#include <string.h>
	
	int yylex(void);
	void yyerror(char *);
%}

%token Keyword Identifier Delimiter AddSub MulDiv OpenBracket CloseBracket Assignment Comparison LogicOp 

%token String Integer Float Constant Bool  

%token For While If Then Else Switch Case Colon Repeat Until

%%
program : line program |;
line :  var Delimiter{printf("Variable Declaration\n");} |
		for_loop {printf("For Loop\n");} |
		while_loop {printf("While Loop\n");} |
		assign Delimiter{printf("Assignment Operation\n");};

for_loop:	For OpenBracket var Delimiter expr Delimiter assign CloseBracket line |
			For OpenBracket assign Delimiter expr Delimiter assign CloseBracket line;

while_loop: While OpenBracket expr CloseBracket line;
		
		
var	 :		Constant Keyword assign 	| Keyword assign |
			Constant Keyword Identifier	| Keyword Identifier;
			

assign : 	Identifier Assignment expr | Identifier Assignment String;
		
expr : 		term | expr AddSub term | expr LogicOp term;
		
term :		factor | term MulDiv factor | term Comparison factor;
			
factor :	OpenBracket expr CloseBracket | BoolValue | Float | Integer | Identifier;	

		
%%

void yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}

int main(void){
	yyparse();
	return 0;
}
