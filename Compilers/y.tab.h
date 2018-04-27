
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     Keyword = 258,
     Identifier = 259,
     Delimiter = 260,
     AddSub = 261,
     MulDiv = 262,
     OpenBracket = 263,
     CloseBracket = 264,
     Assignment = 265,
     Comparison = 266,
     LogicOp = 267,
     String = 268,
     Integer = 269,
     Float = 270,
     Constant = 271,
     Bool = 272,
     For = 273,
     While = 274,
     If = 275,
     Then = 276,
     Else = 277,
     Switch = 278,
     Case = 279,
     Colon = 280,
     Repeat = 281,
     Until = 282,
     Break = 283,
     Default = 284,
     LOWER_THAN_ELSE = 285
   };
#endif
/* Tokens.  */
#define Keyword 258
#define Identifier 259
#define Delimiter 260
#define AddSub 261
#define MulDiv 262
#define OpenBracket 263
#define CloseBracket 264
#define Assignment 265
#define Comparison 266
#define LogicOp 267
#define String 268
#define Integer 269
#define Float 270
#define Constant 271
#define Bool 272
#define For 273
#define While 274
#define If 275
#define Then 276
#define Else 277
#define Switch 278
#define Case 279
#define Colon 280
#define Repeat 281
#define Until 282
#define Break 283
#define Default 284
#define LOWER_THAN_ELSE 285




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


