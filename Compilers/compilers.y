%{
	#include <stdio.h>
	#include <math.h>
	#include <string.h>
	
	int yylex(void);
	void yyerror(char *);
%}

%token Keyword Identifier Delimiter AddSub MulDiv OpenBracket CloseBracket Assignment Comparison LogicOp 

%token String Integer Float Constant Bool  

%token For While If Then Else Switch Case Colon Repeat Until Break Default

%token OpenCurlyBrace CloseCurlyBrace Comma Return

%nonassoc LOWER_THAN_ELSE
%nonassoc Else;

%%
program : line program |;
line :  var Delimiter{printf("Variable Declaration\n");} |
		for_loop {printf("For Loop\n");} |
		while_loop {printf("While Loop\n");} |
		stmt {printf("If statement\n");}|
		switch_case{printf("switch case\n");} |
		block {printf("Block\n");} |
		function {printf("Function\n");} |
		assign Delimiter{printf("Assignment Operation\n");};

for_loop:	For OpenBracket var Delimiter expr Delimiter assign CloseBracket line |
			For OpenBracket assign Delimiter expr Delimiter assign CloseBracket line;

while_loop: While OpenBracket expr CloseBracket line;
		
		
var	 :		Constant Keyword assign 	| Keyword assign|
			Constant Keyword Identifier	| Keyword Identifier;
			

assign : 	Identifier Assignment expr | Identifier Assignment String;
		
expr : 		term | expr AddSub term | expr LogicOp term;
		
term :		factor | term MulDiv factor | term Comparison factor;
			
factor :	OpenBracket expr CloseBracket | Bool | Float | Integer | Identifier;

stmt: If OpenBracket expr CloseBracket Then line  %prec LOWER_THAN_ELSE;
      | If OpenBracket expr CloseBracket Then line Else line;

switch_case: Switch OpenBracket Identifier CloseBracket case_switch;

case_switch: case_struct case_switch | Default line;

case_struct: Case OpenBracket type CloseBracket Colon line Break Delimiter;

type: Integer | Float | String;

block: 	OpenCurlyBrace program CloseCurlyBrace ;

function_block: OpenCurlyBrace program Return Identifier Delimiter CloseCurlyBrace
                |OpenCurlyBrace program CloseCurlyBrace;

function: Keyword Identifier OpenBracket parameters CloseBracket function_block |
Constant Keyword Identifier OpenBracket parameters CloseBracket function_block ;


parameters: parameter | ;
parameter: parameter_name multipleparam;
parameter_name: Constant Keyword Identifier	| Keyword Identifier;

multipleparam: Comma parameter |;		
 	  
%%

void yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}

int main(void){
	yyparse();
	return 0;
}
