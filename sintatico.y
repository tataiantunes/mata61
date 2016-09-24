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
%start program;

%token T_OPENPAR T_CLOSEPAR T_COMMA T_SEMICOL T_ASSIGN T_NUMBER T_DO T_ELSE T_ELSEIF T_END T_FOR T_FUNCTION T_IF T_LOCAL T_NIL T_NOT T_RETURN T_THEN T_WHILE T_NAME
%left  T_EQ T_NEQ T_LTEQ T_GTEQ T_LT T_GT
%left  T_PLUS T_MINUS
%left  T_TIMES T_DIV
%left  T_AND T_OR




%%
/* Sintaxe da Linguagem */

program         : bloco
                ;

bloco           : comando bloco
                | comandoret
                ;

comando         : T_SEMICOL
                | listadenomes T_ASSIGN listaexp
                | chamadadefuncao
                | T_DO bloco T_END
                | T_WHILE exp T_DO bloco T_END
                | T_FOR T_NAME T_ASSIGN exp T_COMMA exp T_COMMA exp T_DO bloco T_END
                | T_IF exp T_THEN bloco elseifthen T_ELSE bloco T_END
                | T_FUNCTION T_NAME T_OPENPAR listadenomes T_CLOSEPAR bloco T_END
                | T_LOCAL listadenomes T_ASSIGN listaexp
                ;

elseifthen      : T_ELSEIF exp T_THEN bloco elseifthen
		;

comandoret      : T_RETURN 
                | T_RETURN listaexp
                | T_RETURN T_SEMICOL
                | T_RETURN listaexp T_SEMICOL
                ;

exp             : T_NUMBER
                | T_NAME
                | T_NIL
                | chamadadefuncao
                | exp opbin exp //{ $$ = $1 opbin $3 }
                | opunaria exp
                | T_OPENPAR exp T_CLOSEPAR
                ;

chamadadefuncao : T_NAME T_OPENPAR T_CLOSEPAR
                | T_NAME T_OPENPAR listaexp T_CLOSEPAR
                ;

listadenomes    : T_NAME virgulanomes
                ;

virgulanomes    : T_COMMA T_NAME virgulanomes
                ;

listaexp        : exp virgulaexp
                ;

virgulaexp      : T_COMMA exp virgulaexp 
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

/*
int main (void) {

	return yyparse ( );
}*/

void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}

