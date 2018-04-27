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

%token OpenCurlyBrace CloseCurlyBrace Comma Void

%%
program : line program |;
line :  var Delimiter{printf("Variable Declaration\n");} |
		for_loop {printf("For Loop\n");} |
		while_loop {printf("While Loop\n");} |
		assign Delimiter{printf("Assignment Operation\n");} |
		repeat_until {printf("Repeat Until\n");} |
		block {printf("Block\n");} |
		function {printf("Function\n");} ;

for_loop:	For OpenBracket var Delimiter expr Delimiter assign CloseBracket line |
			For OpenBracket assign Delimiter expr Delimiter assign CloseBracket line;

while_loop: While OpenBracket expr CloseBracket line;
	
block: 	OpenCurlyBrace program CloseCurlyBrace ;	

function: Keyword Identifier OpenBracket parameters CloseBracket block |
Constant Keyword Identifier OpenBracket parameters CloseBracket block  ;


parameters: parameter | ;
parameter: parameter_name multipleparam;
parameter_name: Constant Keyword Identifier	| Keyword Identifier;

multipleparam: Comma parameter |;		
		
		
repeat_until: Repeat line Until expr Delimiter;
		
var	 :		Constant Keyword assign 	| Keyword assign |
			Constant Keyword Identifier	| Keyword Identifier;
			

assign : 	Identifier Assignment expr | Identifier Assignment String;
		
expr : 		term | expr AddSub term | expr LogicOp term;
		
term :		factor | term MulDiv factor | term Comparison factor;
			
factor :	OpenBracket expr CloseBracket | Bool | Float | Integer | Identifier;	

		
%%

void yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}

int main(void){
	yyparse();
	return 0;
}
