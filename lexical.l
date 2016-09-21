%{
    /*    Alunas: Andressa Andrade e Renata Antunes
    Classes possíveis para os tokens da linguagem:
    T_NAME, T_NUMBER,T_AND, T_NOT, T_OR, T_ELSEIF, T_WHILE, T_DO, T_FUNCTION,
    T_END, T_FOR, T_ELSE, T_IF, T_THEN, T_RETURN, T_LOCAL, T_NIL, T_PLUS, T_MINUS,
    T_TIMES, T_DIV, T_COMMA, T_OPENPAR, T_CLOSEPAR, T_SEMICOL, T_ASSIGN,T_EQ, T_NEQ,
    T_LTEQ, T_GTEQ, T_LT, T_GT */
    #include <stdio.h>
    #include <stdlib.h>
%}

%option yylineno
%option noyywrap

comment      --(.)*
multicomment (--\[\[--)(\n*|.*)*(--\]\]--)
delim  [ \t\n\r\v\f]
ws     {delim}+
digit  [0-9]
letters [A-Za-z_]
name   {letters}+({letters}|{digit})*
number {digit}+

%%

{multicomment}          {}
{comment}               {}
{number}                {fprintf(yyout, "[T_NUMBER, \"%s\"],\n", yytext);}
"and"                   {fprintf(yyout, "[T_AND, \"%s\"],\n", yytext);}
"not"                   {fprintf(yyout, "[T_NOT, \"%s\"],\n", yytext);}
"or"                    {fprintf(yyout, "[T_OR, \"%s\"],\n", yytext);}
"elseif"                {fprintf(yyout, "[T_ELSEIF, \"%s\"],\n", yytext);}
"while"                 {fprintf(yyout, "[T_WHILE, \"%s\"],\n", yytext);}
"do"                    {fprintf(yyout, "[T_DO, \"%s\"],\n", yytext);}
"function"              {fprintf(yyout, "[T_FUNCTION, \"%s\"],\n", yytext);}
"end"                   {fprintf(yyout, "[T_END, \"%s\"],\n", yytext);}
"for"                   {fprintf(yyout, "[T_FOR, \"%s\"],\n", yytext);}
"else"                  {fprintf(yyout, "[T_ELSE, \"%s\"],\n", yytext);}
"if"                    {fprintf(yyout, "[T_IF, \"%s\"],\n", yytext);}
"then"                  {fprintf(yyout, "[T_THEN, \"%s\"],\n", yytext);}
"return"                {fprintf(yyout, "[T_RETURN, \"%s\"],\n", yytext);}
"local"                 {fprintf(yyout, "[T_LOCAL, \"%s\"],\n", yytext);}
"nil"                   {fprintf(yyout, "[T_NIL, \"%s\"],\n", yytext);}
{name}                  {fprintf(yyout, "[T_NAME, \"%s\"],\n", yytext);}
{ws}                    {}
"=="          {fprintf(yyout, "[T_EQ, \"%s\"],\n", yytext);}
"~="          {fprintf(yyout, "[T_NEQ, \"%s\"],\n", yytext);} 
"<="          {fprintf(yyout, "[T_LTEQ, \"%s\"],\n", yytext);}
">="          {fprintf(yyout, "[T_GTEQ, \"%s\"],\n", yytext);}
[=]           {fprintf(yyout, "[T_ASSIGN, \"%s\"],\n", yytext);}
[<]           {fprintf(yyout, "[T_LT, \"%s\"],\n", yytext);}
[>]           {fprintf(yyout, "[T_GT, \"%s\"],\n", yytext);}
[-]           {fprintf(yyout, "[T_MINUS, \"%s\"],\n", yytext);}
[*]           {fprintf(yyout, "[T_TIMES, \"%s\"],\n", yytext);}
[/]           {fprintf(yyout, "[T_DIV, \"%s\"],\n", yytext);}
[,]           {fprintf(yyout, "[T_COMMA, \"%s\"],\n", yytext);}
[+]           {fprintf(yyout, "[T_PLUS, \"%s\"],\n", yytext);}
[(]           {fprintf(yyout, "[T_OPENPAR, \"%s\"],\n", yytext);}
[)]           {fprintf(yyout, "[T_CLOSEPAR, \"%s\"],\n", yytext);}
[;]           {fprintf(yyout, "[T_SEMICOL, \"%s\"],\n", yytext);}

.             {printf("<%s>: Not defined, Line: %u\n",yytext, yylineno);}

%%

main(int argc, char *argv[]){
       
    extern FILE *yyin;
    extern FILE *yyout;

    if (argc > 3){
        printf("O programa deve receber os argumentos...\n");
        exit(1);
    }
    else{

        yyin = fopen (argv[1], "r");
        if (!yyin){
            puts ("Não foi possivel abrir o arquivo de entrada\n");
            exit(1);
            }else{
            yyout = fopen(argv[2], "w");
            if (!yyout){
                puts ("Não foi possivel criar o arquivo de saida\n");
                exit(1);
            }else{
                while(yylex()){
                
                }
            }
            fclose(yyout);
            }
            fclose(yyin);
    }
    return 0;
 }