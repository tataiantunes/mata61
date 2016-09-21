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
%}


%token T_OPENPAR 
%token T_CLOSEPAR
%token T_PLUS 
%token T_MINUS
%token T_TIMES 
%token T_DIV 
%token T_COMMA
%token T_SEMICOL 
%token T_ASSIGN
%token T_EQ
%token T_NEQ
%token T_LTEQ
%token T_GTEQ
%token T_LT
%token T_GT
%token T_NUMBER
%token T_AND 
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
%token T_OR 
%token T_RETURN
%token T_THEN 
%token T_WHILE 

/*YACC definitions 
%union {int num; char id;} 
%start line
%token print
%token exit_command
%token <num> number
%token <id> identifier
%type <num> line exp term
%type <id> assignment
*/

%%
/* Sintaxe da Linguagem */

program         : bloco
bloco           : {comando} [comandoret]
/*
Note que algumas funcoes pre-definidas sao incluidas linguagem, em especial a 
funcao que exibe uma expressao na tela seguido de uma quebra de linha (\n)
*/
line            : '\n'
                : exp '\n'
comando         : ';'
                | listadenomes '=' listaexp
                | chamadadefuncao
                | do blobo end
                | while exp do bloco end
                | for NOME '=' exp ',' exp [',' exp] do bloco end
                | if exp then bloco {elseif exp then bloco} [else bloco] end 
                | function NOME '(' [listadenomes] ')' bloco end
                | local listadenomes ['=' listaexp] 
comandoret      : return [listaexp] [';']
exp             : NUMERO
                | NOME
                | nil
                | chamadadefuncao
                | exp opbin exp 
                | opunaria exp
                | '(' exp ')'
chamadadefuncao : NOME '(' [listaexp] ')'
listadenomes    : NOME {',' NOME}
listaexp        : exp {',' exp}
opbin           : `+´ 
                | '-' 
                | '*' 
                | '/' 
                | '<' 
                | '<=' 
                | '>' 
                | '>=' 
                | '==' 
                | '~=' 
                | and 
                | or  
opunaria        : '-'
                | not
 

%%

int main (void) {

	return yyparse ( );
}

void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
