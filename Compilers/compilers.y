%{
	#include <stdio.h>
	#include <math.h>
	#include <string.h>
	
	int yylex(void);
	void yyerror(char *);
%}

%token Keyword Identifier Delimiter AddSub MulDiv OpenBracket CloseBracket OpenCurlyBrace CloseCurlyBrace Assignment Comparison LogicOp 

%token String Integer Float Constant Bool  

%token For While If Then Else Switch Case Colon Repeat Until Break Default

%nonassoc LOWER_THAN_ELSE
%nonassoc Else;

%%

multiline : line multiline | ;

line :  var Delimiter{printf("//Variable Declaration\n");} |
		for_loop {printf("//For Loop\n");} |
		while_loop {printf("//While Loop\n");} |
		repeat_until {printf("//Repeat Until\n");} |
		stmt {printf("//If Statement\n");} |
		switch_case{printf("//Switch Case\n");} |
		assign Delimiter{printf("//Assignment Operation\n");};

for_loop:	For OpenBracket var Delimiter expr Delimiter assign CloseBracket Block |
			For OpenBracket assign Delimiter expr Delimiter assign CloseBracket Block;

while_loop: While OpenBracket expr CloseBracket Block;

repeat_until: Repeat Block Until expr Delimiter;

stmt: If OpenBracket expr CloseBracket Then Block  %prec LOWER_THAN_ELSE;
      | If OpenBracket expr CloseBracket Then Block Else Block;
	  
switch_case: Switch OpenBracket Identifier CloseBracket OpenCurlyBrace case_switch CloseCurlyBrace;

case_switch: case_struct case_switch | Default Colon multiline;

case_struct: Case type Colon multiline Break Delimiter;

type: Integer | Float | String | Bool;
	  
		
var	 :		Constant Keyword assign 	| Keyword assign |
			Constant Keyword Identifier	| Keyword Identifier;
			

assign : 	Identifier Assignment expr | Identifier Assignment String;
		
expr : 		term | expr AddSub term | expr LogicOp term;
		
term :		factor | term MulDiv factor | term Comparison factor;
			
factor :	OpenBracket expr CloseBracket | Bool | Float | Integer | Identifier;

Block	:	OpenCurlyBrace multiline CloseCurlyBrace | line;	

		
%%

void yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}

int main(void){
	yyparse();
	return 0;
}
