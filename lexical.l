%{
    /*    Alunas: Andressa Andrade e Renata Antunes
    Classes possíveis para os tokens da linguagem:
    T_NAME, T_NUMBER,T_AND, T_NOT, T_OR, T_ELSEIF, T_WHILE, T_DO, T_FUNCTION,
    T_END, T_FOR, T_ELSE, T_IF, T_THEN, T_RETURN, T_LOCAL, T_NIL, T_PLUS, T_MINUS,
    T_TIMES, T_DIV, T_COMMA, T_OPENPAR, T_CLOSEPAR, T_SEMICOL, T_ASSIGN,T_EQ, T_NEQ,
    T_LTEQ, T_GTEQ, T_LT, T_GT */
    #include <ctype.h>
    #include <stdlib.h>
    #include <string.h>
    #include "y.tab.h"

%}

comment      --(.)*
multicomment (--\[\[--)(\n*|.*)*(--\]\]--)
delim  [ \t\n\r\v\f]
ws     {delim}+
digit  [0-9]
letters [A-Za-z_]
name   {letters}+({letters}|{digit})*
number {digit}+

%%

{multicomment}          
{comment}               
{number}                { 
                          yylval.ival = atoi(yytext);
                          return T_NUMBER;
                        }
"and"                   { strcpy(yylval.sval, yytext);
                          return T_AND;
                        }
"not"                   { strcpy(yylval.sval, yytext);
                          return T_NOT;
                        }
"or"                    { strcpy(yylval.sval, yytext);
                          return T_OR;
                        }
"elseif"                { strcpy(yylval.sval, yytext);
                          return T_ELSEIF;
                        }
"while"                 { strcpy(yylval.sval, yytext);
                          return T_WHILE;
                        }
"do"                    { strcpy(yylval.sval, yytext);
                          return T_DO;
                        }
"function"              { strcpy(yylval.sval, yytext);
                          return T_FUNCTION;
                        }
"end"                   { strcpy(yylval.sval, yytext);
                          return T_END;
                        }
"for"                   { strcpy(yylval.sval, yytext);
                          return T_FOR;
                        }
"else"                  { strcpy(yylval.sval, yytext);
                          return T_ELSE;
                        }
"if"                    { strcpy(yylval.sval, yytext);
                          return T_IF;
                        }
"then"                  { strcpy(yylval.sval, yytext);
                          return T_THEN;
                        }
"return"                { strcpy(yylval.sval, yytext);
                          return T_NUMBER;
                        }
"local"                 { strcpy(yylval.sval, yytext);
                          return T_NUMBER;
                        }
"nil"                   { strcpy(yylval.sval, yytext);
                          return T_NUMBER;
                        }
{name}                  { strcpy(yylval.sval, yytext);
                          return T_NAME;
                        }
{ws}                    
"=="          { strcpy(yylval.sval, yytext);
                          return T_EQ;
                        }
"~="          { strcpy(yylval.sval, yytext);
                          return T_NEQ;
                        }
"<="          { strcpy(yylval.sval, yytext);
                          return T_LTEQ;
                        }
">="          { strcpy(yylval.sval, yytext);
                          return T_GTEQ;
                        }
[=]           { strcpy(yylval.sval, yytext);
                          return T_ASSIGN;
                        }
[<]           { strcpy(yylval.sval, yytext);
                          return T_LT;
                        }
[>]           { strcpy(yylval.sval, yytext);
                          return T_GT;
                        }
[-]           { strcpy(yylval.sval, yytext);
                          return T_MINUS;
                        }
[*]           { strcpy(yylval.sval, yytext);
                          return T_TIMES;
                        }
[/]           { strcpy(yylval.sval, yytext);
                          return T_DIV;
                        }
[,]           { strcpy(yylval.sval, yytext);
                          return T_COMMA;
                        }
[+]           { strcpy(yylval.sval, yytext);
                          return T_PLUS;
                        }
[(]           { strcpy(yylval.sval, yytext);
                          return T_OPENPAR;
                        }
[)]           { strcpy(yylval.sval, yytext);
                          return T_CLOSEPAR;
                        }
[;]           { strcpy(yylval.sval, yytext);
                          return T_SEMICOL;
                        }

.             //{printf("<%s>: Not defined\n",yytext);}

%%


int main(void) {
    yyparse();
}



void yyerror(const char *str)
{
        printf("\n\nerror: %s\n",str);
}