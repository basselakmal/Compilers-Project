%{
	#include <stdio.h>
	#include <math.h>
	#include <string.h>
	
	int yylex(void);
	void yyerror(char *);
	double calcArith(double op1, char* op, double op2);
	int calcLogic(int op1, char* op, int op2);
%}

%token Keyword String Integer Float Constant BoolValue Delimiter AddSub MulDiv Bracket Comparison LogicOp Identifier Assignment 

%%
program : line program |;
line :  var {printf("Variable Declaration\n");} |
		assign {printf("Assignment Operation\n");};

		
var	 :		Constant Keyword Identifier Assignment expr Delimiter 	| Keyword Identifier Assignment expr Delimiter |
			Constant Keyword Identifier Delimiter					| Keyword Identifier Delimiter;

assign : 	Identifier Assignment expr Delimiter;
		
expr : 		String | term | expr AddSub term | expr LogicOp term;
		
term :		factor | term MulDiv factor | term Comparison factor;
			
factor :	Bracket expr Bracket | BoolValue | Float | Integer | Identifier;	

		
%%

void yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}

double calcArith(double op1, char* op, double op2){
	
	if(!strcmp(op, "+"))
		return op1 + op2;
	if(!strcmp(op, "-"))
		return op1 - op2;
	if(!strcmp(op, "*"))
		return op1 * op2;
	if(!strcmp(op, "/"))
		return op1 / op2;
}

int calcLogic(int op1, char* op, int op2){

	if(!strcmp(op, "=="))
		return op1 == op2;
	if(!strcmp(op, "!="))
		return op1 != op2;
	if(!strcmp(op, ">"))
		return op1 > op2;
	if(!strcmp(op, "<"))
		return op1 < op2;
	if(!strcmp(op, "<="))
		return op1 <= op2;
	if(!strcmp(op, ">="))
		return op1 >= op2;
		
		
	if(!strcmp(op, "&&"))
		return op1 && op2;
	if(!strcmp(op, "||"))
		return op1 || op2;
}

int main(void){
	yyparse();
	return 0;
}
