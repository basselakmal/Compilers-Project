%{
	#include <stdio.h>
	#include <math.h>
	#include <string.h>
	
	int yylex(void);
	void yyerror(char *);
	FILE *yyin;

%}

%token Keyword Identifier Delimiter Comma AddSub MulDiv OpenBracket CloseBracket OpenCurlyBrace CloseCurlyBrace Assignment Comparison LogicOp 

%token String Integer Float Constant Bool  

%token For While If Then Else Switch Case Colon Repeat Until Break Default Return Void Cin Cout Endl LeftShift RightShift

%nonassoc LOWER_THAN_ELSE
%nonassoc Else;

%start start

%%

start		:	function start | global_var start |;

global_var	:	var Delimiter {printf("//Global Variable Declaration\n");};
function	:	func_str {printf("//%s Function\n", $1);};

multiline	:	line multiline | ;

line		:	var Delimiter{printf("//Variable Declaration\n\n");} |
				for_loop {printf("//For Loop\n\n");} |
				while_loop {printf("//While Loop\n\n");} |
				repeat_until {printf("//Repeat Until\n\n");} |
				stmt {printf("//If Statement\n\n");} |
				switch_case {printf("//Switch Case\n\n");} |
				func_call Delimiter {printf("//Function Call\n\n");} |
				cin Delimiter {printf("//Get User Intput\n\n");} |
				Cout cout Delimiter {printf("//Print Output\n\n");} |
				assign Delimiter {printf("//Assignment Operation\n\n");};
				
cout		:	cout LeftShift expr | cout LeftShift Endl | ;

cin			:	Cin RightShift Identifier

for_loop	:	For OpenBracket var Delimiter expr Delimiter assign CloseBracket Block |
				For OpenBracket assign Delimiter expr Delimiter assign CloseBracket Block;

while_loop	:	While OpenBracket expr CloseBracket Block;

repeat_until:	Repeat Block Until expr Delimiter;

stmt		:	If OpenBracket expr CloseBracket Block  %prec LOWER_THAN_ELSE |
				If OpenBracket expr CloseBracket Block Else Block;
	  
switch_case	:	Switch OpenBracket Identifier CloseBracket OpenCurlyBrace case_switch CloseCurlyBrace;

case_switch	:	case_struct case_switch | Default Colon multiline;

case_struct	:	Case expr Colon multiline Break Delimiter;

func_str	:	Keyword Identifier OpenBracket params CloseBracket OpenCurlyBrace multiline Return expr Delimiter CloseCurlyBrace {$$=$2;}|
				Void Identifier OpenBracket params CloseBracket OpenCurlyBrace multiline CloseCurlyBrace {$$=$2;}|
				Void Identifier OpenBracket CloseBracket OpenCurlyBrace multiline CloseCurlyBrace {$$=$2;}|
				Keyword Identifier OpenBracket CloseBracket OpenCurlyBrace multiline Return expr Delimiter CloseCurlyBrace {$$=$2;};

func_call	:	Identifier OpenBracket call_params CloseBracket | Identifier OpenBracket CloseBracket;

call_params	:	Identifier Comma params | Identifier;
			
params		:	Keyword Identifier | Constant Keyword Identifier | Keyword Identifier Comma params | Constant Keyword Identifier Comma params;	  
		
var			:	Constant Keyword assign 	| Keyword assign |
				Constant Keyword Identifier	| Keyword Identifier;
			

assign 		: 	Identifier Assignment expr;
		
expr 		:	term | expr AddSub term | expr LogicOp term;
		
term 		:	factor | term MulDiv factor | term Comparison factor;
			
factor 		:	OpenBracket expr CloseBracket | Bool | Float | Integer | String| Identifier | func_call;

Block		:	OpenCurlyBrace multiline CloseCurlyBrace | line;	

		
%%

void yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}

int main(void){
	//yyin = fopen("code.txt", "r");
	yyparse();
	//fclose(yyin);
	return 0;
}
