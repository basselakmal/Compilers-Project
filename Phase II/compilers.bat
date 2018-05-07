@echo off
bison -dy %~n0.y
flex %~n0.l
gcc lex.yy.c y.tab.c -o %~n0.exe
echo Launching file: %~n0.exe
%~n0.exe
@pause
