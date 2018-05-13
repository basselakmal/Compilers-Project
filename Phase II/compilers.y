%{
	#define _GNU_SOURCE

	#include <stdio.h>
	#include <math.h>
	#include <stdlib.h>
	#include <string.h>
	#pragma GCC diagnostic push
	#pragma GCC diagnostic ignored "-Wint-conversion"
	
	int yylex(void);
	void yyerror(char *);
	FILE *yyin;
	
	struct SymbolTable{
	char identifier [50];
	char type [50];
	int isConst;
	};

	struct SymbolTable Table[50];
	int SymbolTableCount = 0;
	
	int yylineno;

	void undeclaredVariable(char identifier[]){
		fprintf(stderr,"Error: Undeclared Variable '%s'!\n", identifier);
	}
	
	void previouslyDeclaredVariable(char identifier[]){
		fprintf(stderr,"Previously Declared Variable '%s'!\n", identifier);
	}
	
	void typeMismatch(char expected[], char found[]){
		fprintf(stderr,"Expected: %s\nFound: %s\n", expected, found);
	}
	
	void customError(char err[]){
		fprintf(stderr,"Error: %s\n", err);
	}

	int getIdentifierIndex(char identifier[]){
		for(int i=0; i<SymbolTableCount; i++){
			if(strcmp(Table[i].identifier, identifier) == 0)
				return i;
		}
		return -1;
	}

	char* getVariableType(char identifier[]){	
		int i = getIdentifierIndex(identifier);
		if(i==-1){
			undeclaredVariable(identifier);
			return "";
		}

		char* returnVal = malloc(strlen(Table[i].type)+1);
		strcpy(returnVal, Table[i].type);
		returnVal[strlen(Table[i].type)] = '\0';
		return returnVal;
	}

	int compareTypes(char expected[], char expressionType[]){
		if(strcmp(expressionType, "")==0)
			return -1;

		if(strcmp(expected, expressionType)==0 || strcmp(expressionType, "default")==0 || strcmp(expected, "default")==0)
			return 0;
		typeMismatch(expected, expressionType);
		return -1;
	}

	int checkAssignment(char expected[], char expressionType[], int isInitialization){
		
		int i = getIdentifierIndex(expected);
		if(i==-1){
			undeclaredVariable(expected);
			return -1;
		}

		if(compareTypes(Table[i].type, expressionType) ==0){
			if(Table[i].isConst == 0)
				return 0;
			else {
				if(isInitialization == 0){
					customError("Can not assign a value to a constant!");
					return -1;
				}
				else{
					return 0;
				}
			
			}
		}
		
		return -1;
	}


	int removeVariable(char identifier[]){
		int i = getIdentifierIndex(identifier);
		if(i==-1){
			undeclaredVariable(identifier);
			return -1;
		}

		for(int j=i+1; j<SymbolTableCount; j++){
			Table[j-1] = Table[j];
		}
		SymbolTableCount --;
		return 0;
	}

	void printSymbolTable(){
		
		printf("\n\t\t***The Symbol Table***\n");
		printf("------------------------------------------------------------------------------------\n");
		printf("|   %s\t|\t%s\t|\t%s\t|\n", "isConst", "Type", "Identifier");
		printf("|-----------------------------------------------------------------------------------|\n");
		for(int i=0; i<SymbolTableCount; i++){
			printf("|\t%d\t|\t%s\t|\t%s\t|\n", Table[i].isConst, Table[i].type, Table[i].identifier);
		}
		printf("------------------------------------------------------------------------------------\n");

		printf("\n");
		fflush(stdout);
	}

	int addVariable(char type[], char identifier[], int isConst){

		int i = getIdentifierIndex(identifier);
		if(i != -1)
		{
			previouslyDeclaredVariable(identifier);
			return -1;
		}

		//Brand new variable!

		strcpy(Table[SymbolTableCount].identifier, identifier);
		Table[SymbolTableCount].identifier[strlen(identifier)] = '\0';
		strcpy(Table[SymbolTableCount].type, type);
		Table[SymbolTableCount].type[strlen(type)] = '\0';
		Table[SymbolTableCount].isConst = isConst;
		SymbolTableCount += 1;
		return 0;
	}

	char* matchArith (char instr[]){
		char instr_type[100];
		char inner_instr[100];
		char inner_instr_type[100];

		int j=0;
		strcpy(instr_type, "");
		
		for(int i=0; i<strlen(instr); i++){
			strcpy(inner_instr, "");
			strcpy(inner_instr_type, "");

			switch(instr[i]){

				case '(':
					break;
				
				case ')':
					break;

				case '+' :
					break;

				case '-' :
					break;

				case '*' :
					break;
				
				case '/' :
					break;

				default:
					strcpy(inner_instr, "");
					strcpy(inner_instr_type, "");
					j=0;
					while(1){
					
						if(instr[i+j] == '+' || instr[i+j] == '-' || instr[i+j] == '*' || instr[i+j] == '/' || instr[i+j] == '(' || instr[i+j] == ')' || instr[i+j] == '\0')
							break;
						inner_instr_type[j] = instr[i+j];
						j++;
					}
					inner_instr_type[j] = '\0';
					i=i+j-1;
					if(strcmp(instr_type, "")==0){
						if(strcmp(inner_instr_type, "int") == 0 || strcmp(inner_instr_type, "float") == 0){
							strcpy(instr_type, inner_instr_type);
							instr_type[j] = '\0';
						}
						else{
							typeMismatch("int or float", inner_instr_type);
							return "";
						}	
					}
					if(strcmp(instr_type, inner_instr_type) != 0){
						typeMismatch(instr_type, inner_instr_type);
						return "";
					}
					
					break;	
			}

		}
		char* returnVal = malloc(strlen(instr_type)+1);
		strcpy(returnVal, instr_type);
		returnVal[strlen(instr_type)] = '\0';

		return returnVal;
	}
	
	char* matchLogicOP (char instr[]){
		char instr_type[100];
		char inner_instr[100];
		char inner_instr_type[100];

		int j=0;
		strcpy(instr_type, "");
		
		for(int i=0; i<strlen(instr); i++){
			strcpy(inner_instr, "");
			strcpy(inner_instr_type, "");

			switch(instr[i]){

				case '&' :
					break;

				case '|' :
					break;
				
				default:
					strcpy(inner_instr, "");
					strcpy(inner_instr_type, "");
					j=0;
					while(1){
					
						if(instr[i+j] == '&' || instr[i+j] == '|' || instr[i+j] == '\0')
							break;
						inner_instr_type[j] = instr[i+j];
						
						j++;
					}
					inner_instr_type[j] = '\0';
					i=i+j-1;
					if(strcmp(instr_type, "")==0){
						if(strcmp(inner_instr_type, "bool") == 0){
							strcpy(instr_type, inner_instr_type);
							instr_type[j] = '\0';
						}
						else{
							typeMismatch("bool", inner_instr_type);
							return "";
						}	
					}
					else{	
						if(strcmp(instr_type, inner_instr_type) != 0){
							typeMismatch(instr_type, inner_instr_type);
							return "";
						}
					}
					break;	
			}

		}
		char* returnVal = malloc(strlen(instr_type)+1);
		strcpy(returnVal, instr_type);
		returnVal[strlen(instr_type)] = '\0';

		return returnVal;
	}


	char* matchComparison (char instr[]){
		char instr_type[100];
		char inner_instr[100];
		char inner_instr_type[100];
		int j=0;
		strcpy(instr_type, "");
		for(int i=0; i<strlen(instr); i++){
			strcpy(inner_instr, "");
			strcpy(inner_instr_type, "");

			switch(instr[i]){

				case '=':
					break;
				
				case '<':
					if(strcmp(instr_type, "bool") == 0){
						typeMismatch("==", "<");
						return "";
					}
					break;

				case '>' :
					if(strcmp(instr_type, "bool") == 0){
						typeMismatch("==", ">");
						return "";
					}
					break;

				case '(' :
					break;

				case ')' :
					break;
				
				default:
					strcpy(inner_instr, "");
					strcpy(inner_instr_type, "");
					j=0;
					while(1){
					
						if(instr[i+j] == '=' || instr[i+j] == '<' || instr[i+j] == '>' || instr[i+j] == '(' || instr[i+j] == ')' || instr[i+j] == '\0')
							break;
						inner_instr_type[j] = instr[i+j];
						j++;
					}

					inner_instr_type[j] = '\0';


					i=i+j-1;
					if(strcmp(instr_type, "")==0){
						if(strcmp(inner_instr_type, "int") == 0 || strcmp(inner_instr_type, "float") == 0 || strcmp(inner_instr_type, "bool") == 0){
							strcpy(instr_type, inner_instr_type);
							instr_type[j] = '\0';
						}
						else{
							typeMismatch("int, float or bool", inner_instr_type);
							return "";
						}	
					}
					else{
						if(strcmp(instr_type, inner_instr_type) != 0){

							typeMismatch(instr_type, inner_instr_type);
							return "";
						}
						if(strcmp(instr_type, "int") == 0 || strcmp(instr_type, "float") == 0)
							strcpy(instr_type, "bool");
					}
					break;	
			}

		}
		char* returnVal = malloc(strlen(instr_type)+1);
		strcpy(returnVal, instr_type);
		returnVal[strlen(instr_type)] = '\0';
		return returnVal;
	}


%}


%token Keyword Identifier Delimiter Comma AddSub MulDiv OpenBracket CloseBracket OpenCurlyBrace CloseCurlyBrace Assignment Comparison LogicOp 

%token String Integer Float Constant Bool  

%token For While If Then Else Switch Case Colon Repeat Until Break Default Forbiddentokens

%nonassoc LOWER_THAN_ELSE
%nonassoc Else;


%start start

%%

start		:	line start |  ;

loop_allowed:	for_loop |
				while_loop |
				repeat_until |
				stmt |
				switch_case |
				Identifier assign Delimiter {if(checkAssignment($1, $2, 0) == -1) customError("Error in the assignment statement!");};
				
line		:	var Delimiter {printSymbolTable();}	|
                error Delimiter |
				loop_allowed;
				

for_loop	:	For OpenBracket var Delimiter expr Delimiter Identifier assign CloseBracket loop_allowed {if(compareTypes("bool", $5) == -1 || checkAssignment($7, $8, 0) == -1) customError("Error in the for loop!"); removeVariable($3);}|
				For OpenBracket Identifier assign Delimiter expr Delimiter Identifier assign CloseBracket loop_allowed {if(checkAssignment($3, $4, 0) == -1 || compareTypes("bool", $6) == -1 || checkAssignment($8, $9, 0) == -1) customError("Error in the for loop!");};

while_loop	:	While OpenBracket expr CloseBracket loop_allowed {if(compareTypes("bool", $3) == -1) customError("Error in the while loop!");};

repeat_until:	Repeat loop_allowed Until expr Delimiter {if(compareTypes("bool", $4) == -1) customError("Error in the repeat until loop!");};

stmt		:	If OpenBracket expr CloseBracket loop_allowed  %prec LOWER_THAN_ELSE  {if(compareTypes("bool", $3) == -1) customError("Error in the if statement!");}|
				If OpenBracket expr CloseBracket loop_allowed Else loop_allowed  {if(compareTypes("bool", $3) == -1) customError("Error in the if statement!");};
	  
switch_case	:	Switch OpenBracket Identifier CloseBracket OpenCurlyBrace case_switch CloseCurlyBrace {if(getIdentifierIndex($3)==-1) {customError("Error: undeclared variable!");} else{if(compareTypes(getVariableType($3), $6) == -1) customError("Error in the switch statement. Cases type and switch type don't match!");} };

case_switch	:	case_struct case_switch {if(strcmp($1, $2) != 0 && strcmp($1, "default") != 0 && strcmp($2, "default") != 0) $$ = strdup("Type Mismatch"); else $$ = strdup($1);} | Default Colon loop_allowed {$$ = strdup("default");};

case_struct	:	Case expr Colon loop_allowed Break Delimiter {$$ = strdup($2);};
		
var			:	Constant Keyword Identifier assign {$$ = strdup($3); addVariable($2, $3, 1); if(checkAssignment($3, $4, 1) == -1) removeVariable($3);}| Keyword Identifier assign {$$ = strdup($2); addVariable($1, $2, 0); if(checkAssignment($2, $3, 1) == -1) removeVariable($2);} |
				Constant Keyword Identifier {$$ = strdup($3); addVariable($2, $3, 1);}	| Keyword Identifier {$$ = strdup($2); addVariable($1, $2, 0);};
			

assign 		: 	Assignment expr {$$ = strdup($2);};
		
expr 		:	term {$$ = strdup($1);} | expr AddSub term {$$ = strdup($1); strcat($$, strdup($2)); strcat($$, strdup($3)); $$ = strdup(matchArith($$));} | expr LogicOp term {$$ = strdup($1); strcat($$, strdup($2)); strcat($$, strdup($3)); $$ = strdup(matchLogicOP($$));};
		
term 		:	factor {$$ = strdup($1);} | term MulDiv factor {$$ = strdup($1); strcat($$, strdup($2)); strcat($$, strdup($3)); $$ = strdup(matchArith($$));} | term Comparison factor {$$ = strdup($1); strcat($$, strdup($2)); strcat($$, strdup($3)); $$ = strdup(matchComparison($$));};
			
factor 		:	OpenBracket expr CloseBracket {$$ = strdup($2);} | Bool {$$ = "bool";}| Float {$$="float";} | Integer {$$ = "int";} | String {$$ = "string";}| Identifier {$$ = strdup(getVariableType($1));};

		
%%

void yyerror(char *s){
	fprintf(stderr,"%s: token %s on line %d\n", s,yylval, yylineno);
}

int main(void){
	//yyin = fopen("code.txt", "r");
		
	yyparse();
	
	//fclose(yyin);
	return 0;
}
