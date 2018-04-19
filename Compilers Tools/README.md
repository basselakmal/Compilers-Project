# Instructions:

-Install 3 files to : C:\GnuWin32

-Add the path "C:\GnuWin32\bin" to your "Path" variable in the System Environment Variables.


-To test your installation, open CMD and type "flex --help" or "bison --help".

# Batch File:

-You may use the batch file (test.bat), it's a shortcut for flex + bison + gcc and then runs the output file.

--> But you have to make sure that the batch file (.bat), lexer file (.l), and parser file(.y) all have the same name.

--> The output will be the same name + ".exe"

--> Ex: test.l - test.y - test.bat => test.exe
