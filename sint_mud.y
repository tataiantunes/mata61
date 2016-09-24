%{
    /* Alunas: Andressa Andrade e Renata Antunes
       Classes possíveis para os tokens da linguagem:
       T_NAME, T_NUMBER,T_AND, T_NOT, T_OR, T_ELSEIF, T_WHILE, T_DO, T_FUNCTION,
       T_END, T_FOR, T_ELSE, T_IF, T_THEN, T_RETURN, T_LOCAL, T_NIL, T_PLUS, T_MINUS,
       T_TIMES, T_DIV, T_COMMA, T_OPENPAR, T_CLOSEPAR, T_SEMICOL, T_ASSIGN,T_EQ, T_NEQ,
       T_LTEQ, T_GTEQ, T_LT, T_GT
    */
    void yyerror (const char *str);
    #include <stdio.h>
    #include <stdlib.h>

    extern int yylex();
    extern char* yytext;
    extern int yylineno;
    extern FILE* yyout;
%}

/* Por default, o Bison já possui o tipo INT */

%token T_OPENPAR
%token T_CLOSEPAR
%left  T_PLUS
%left  T_MINUS
%left  T_TIMES
%left  T_DIV
%token T_COMMA
%token T_SEMICOL
%token T_ASSIGN
%left  T_EQ
%left  T_NEQ
%left  T_LTEQ
%left  T_GTEQ
%left  T_LT
%left  T_GT
%token T_NUMBER
%left  T_AND
%token T_DO
%token T_ELSE
%token T_ELSEIF
%token T_END
%token T_FOR
%token T_FUNCTION
%token T_IF
%token T_LOCAL
%token T_NIL
%token T_NOT
%left  T_OR
%token T_RETURN
%token T_THEN
%token T_WHILE

%start program;

%%
/* Sintaxe da Linguagem */

program         : bloco
                ;

bloco           : {comando}
                |[comandoret]
                ;

/*
Note que algumas funcoes pre-definidas sao incluidas linguagem, em especial a
funcao que exibe uma expressao na tela seguido de uma quebra de linha (\n)
*/

line            : '\n'
                | exp '\n'
                ;

comando         : T_SEMICOL
                | listadenomes T_ASSIGN listaexp
                | chamadadefuncao
                | T_DO bloco T_END
                | T_WHILE exp T_DO bloco T_END
                | T_FOR T_NAME T_ASSIGN exp T_COMMA exp [T_COMMA exp] T_DO bloco T_END
                | T_IF exp T_THEN bloco {elseif exp T_THEN bloco} [T_ELSE bloco] T_END
                | T_FUNCTION T_NAME T_OPENPAR [listadenomes] T_CLOSEPAR bloco T_END
                | T_LOCAL listadenomes [T_ASSIGN listaexp]
                ;

comandoret      : T_RETURN [listaexp] [T_SEMICOL]
                ;

exp             : T_NUMBER
                | T_NAME
                | T_NIL
                | chamadadefuncao
                | exp opbin exp { $$ = $1 opbin $3; }
                | opunaria exp
                | T_OPENPAR exp T_CLOSEPAR
                ;

chamadadefuncao : T_NAME T_OPENPAR [listaexp] T_CLOSEPAR
                ;

listadenomes    : T_NAME {T_COMMA T_NAME}
                ;

listaexp        : exp {T_COMMA exp}
                ;

opbin           : T_PLUS
                | T_MINUS
                | T_TIMES
                | T_DIV
                | T_LT
                | T_LTEQ
                | T_GT
                | T_GTEQ
                | T_EQ
                | T_NEQ
                | T_AND
                | T_OR
                ;

opunaria        : T_MINUS
                | T_NOT
                ;

%%

int main (void) {

	return yyparse ( );
}

void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
