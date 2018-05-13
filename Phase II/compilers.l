%{
	#include "y.tab.h"
	#include <string.h>
	#pragma GCC diagnostic push
	#pragma GCC diagnostic ignored "-Wint-conversion"
	int yylineno;
%}
%%

("if")										{yylval=strdup(yytext);return If;}
("then")									{yylval=strdup(yytext); return Then;}
("else")									{yylval=strdup(yytext); return Else;}
("switch")									{yylval=strdup(yytext); return Switch;}
("case")									{yylval=strdup(yytext); return Case;}
(":")										{yylval=strdup(yytext); return Colon;}
("repeat")									{yylval=strdup(yytext); return Repeat;}
("until")									{yylval=strdup(yytext); return Until;}
("break")									{yylval=strdup(yytext); return Break;}
("default")								    {yylval=strdup(yytext); return Default;}

("for")										{yylval=strdup(yytext); return For;}
("while")									{yylval=strdup(yytext); return While;}
("int"|"char"|"string"|"float"|"bool")		{yylval = strdup(yytext); return Keyword;}
("const")									{return Constant;}
("true"|"false")							{yylval = strdup(yytext); return Bool;}

("(")										{yylval = strdup(yytext); return OpenBracket;}
(")")										{yylval = strdup(yytext); return CloseBracket;}
("{")										{yylval = strdup(yytext); return OpenCurlyBrace;}
("}")										{yylval = strdup(yytext); return CloseCurlyBrace;}

("=")										{yylval=strdup(yytext); return Assignment;}
[a-zA-Z_][a-zA-Z0-9_]*						{yylval = strdup(yytext); return Identifier;}		

(\".*\") 									{yylval = strdup(yytext); return String;}
[\n]                                        {yylineno++;}
("-")?[0-9]+\.[0-9]+						{yylval = atof(yytext); return Float;}
("-")?[0-9]+								{yylval = atoi(yytext); return Integer;}

(";")										{return Delimiter;}
(",")										{yylval=strdup(yytext);return Comma;}

("\+"|"-")									{yylval = strdup(yytext); return AddSub;}
("\*"|"/")									{yylval = strdup(yytext); return MulDiv;}
("/"\*(\n|[^\*"/"])*\*"/")											
("//".*)															

("=="|"!="|">"|"<"|">="|"<=")				{yylval = strdup(yytext); return Comparison;}
("&&"|"\|\|")								{yylval = strdup(yytext); return LogicOp;} 
("&"|"!"|"?"|"@"|"#"|"$"|"%"|"~"|"."|">>"|"<<")           {yylval = strdup(yytext); return Forbiddentokens;} 

[ \t]+
%%

int yywrap(void){
	return 1;
}
