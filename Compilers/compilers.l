%{
	#include "y.tab.h"
	#include <string.h>
	#pragma GCC diagnostic push
	#pragma GCC diagnostic ignored "-Wint-conversion"
%}
%%

("if"|"then"|"else"|"repeat"|"until"|"switch")		 						{yylval = strdup(yytext); return Keyword;}
("for")																		{return For;}
("while")																	{return While;}
("int"|"char"|"string"|"float"|"bool")			 							{yylval = strdup(yytext); return Keyword;}
("const")																	{return Constant;}
("true"|"false")															{yylval = strdup(yytext); return BoolValue;}

("(")																		{return OpenBracket;}
(")")																		{return CloseBracket;}

("=")																		{return Assignment;}
[a-zA-Z_][a-zA-Z0-9_]*														{yylval = strdup(yytext); return Identifier;}		

(\".*\") 																	{yylval = strdup(yytext); return String;}
[0-9]+\.[0-9]+																{yylval = atof(yytext); return Float;}
[0-9]+																		{yylval = atoi(yytext); return Integer;}

(";")																		{return Delimiter;}

("\+"|"-")																	{yylval = strdup(yytext); return AddSub;}
("\*"|"/")																	{yylval = strdup(yytext); return MulDiv;}
("/"\*(\n|[^\*"/"])*\*"/")											
("//".*)															

("=="|"!="|">"|"<"|">="|"<=")												{yylval = strdup(yytext); return Comparison;}
("&&"|"\|\|")																{yylval = strdup(yytext); return LogicOp;}

[ \t\n]+
%%

int yywrap(void){
	return 1;
}
