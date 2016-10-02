%{
    /* Alunas: Andressa Andrade e Renata Antunes
       Classes possíveis para os tokens da linguagem:
       T_NAME, T_NUMBER,T_AND, T_NOT, T_OR, T_ELSEIF, T_WHILE, T_DO, T_FUNCTION,
       T_END, T_FOR, T_ELSE, T_IF, T_THEN, T_RETURN, T_LOCAL, T_NIL, T_PLUS, T_MINUS,
       T_TIMES, T_DIV, T_COMMA, T_OPENPAR, T_CLOSEPAR, T_SEMICOL, T_ASSIGN,T_EQ, T_NEQ,
       T_LTEQ, T_GTEQ, T_LT, T_GT
    */
    #include <ctype.h>
    #include <stdlib.h>
    #include <string.h>
    

    char sintatico[256];

    int yywrap(){
        return 1;
    }

%}

%union{
    int ival;
    char sval[256];
};



%token <sval>  T_OPENPAR T_CLOSEPAR T_COMMA T_SEMICOL T_ASSIGN  T_DO T_ELSE T_ELSEIF T_END T_FOR T_FUNCTION T_IF T_LOCAL T_NIL T_NOT T_RETURN T_THEN T_WHILE T_NAME
%token <ival>  T_NUMBER
%left <sVal>   T_LT T_GT T_EQ  T_NEQ T_LTEQ T_GTEQ 
%left <sVal>   T_PLUS T_MINUS
%left <sVal>   T_TIMES T_DIV
%left <sVal>   T_AND T_OR
 

%%
/* Sintaxe da Linguagem */

program         : {printf("[programa\n");} 
                  bloco
                  {printf("]");}  
                ;

bloco           : 
                | {printf("\t[bloco\n");} comando bloco 
                | {printf("\t[bloco\n");} comandoret 
                ;

comando         : {printf("\t[comando");}T_SEMICOL 
		        | listadenomes T_ASSIGN listaexp 
		        | chamadadefuncao
		        | T_DO bloco T_END
		        | T_WHILE exp T_DO bloco T_END
		        | T_FOR T_NAME T_ASSIGN exp T_COMMA exp T_DO bloco T_END
		        | T_FOR T_NAME T_ASSIGN exp T_COMMA exp T_COMMA exp T_DO bloco T_END
		        | T_IF exp T_THEN bloco elseifthen T_END
		        | T_IF exp T_THEN bloco elseifthen  T_ELSE bloco T_END
		        | T_FUNCTION T_NAME T_OPENPAR T_CLOSEPAR bloco T_END T_LOCAL listadenomes
		        | T_FUNCTION T_NAME T_OPENPAR listadenomes T_CLOSEPAR bloco T_END T_LOCAL listadenomes
		        | T_FUNCTION T_NAME T_OPENPAR T_CLOSEPAR bloco T_END T_LOCAL listadenomes T_ASSIGN listaexp
		        | T_FUNCTION T_NAME T_OPENPAR listadenomes T_CLOSEPAR bloco T_END T_LOCAL listadenomes T_ASSIGN listaexp
		        ;

elseifthen      : 
                | T_ELSEIF exp T_THEN bloco elseifthen
                ;

comandoret      : T_RETURN 
                | T_RETURN listaexp
                | T_RETURN T_SEMICOL
                | T_RETURN listaexp T_SEMICOL
                ;

exp             : expbin termos                          
                | opunaria exp                  
                | T_OPENPAR exp T_CLOSEPAR     
                ;

expbin          : 
                | expbin termos opbin 
                ;

termos          : T_NUMBER {printf("%s ",$1);}
                | T_NAME   {printf("%s ",$1);}
                | T_NIL    {printf("nil ");}
                | chamadadefuncao {printf("chamadadefuncao ");}
                ;

chamadadefuncao : T_NAME T_OPENPAR T_CLOSEPAR {printf("%s %s %s",$2, $1, $3);}
                | T_NAME T_OPENPAR listaexp T_CLOSEPAR
                ;

listadenomes    : T_NAME virgulanomes
                ;

virgulanomes    : 
                | T_COMMA T_NAME virgulanomes
                ;

listaexp        : exp virgulaexp  
                ;

virgulaexp      : 
                | T_COMMA exp virgulaexp 
                ;

opbin           : {printf("+");}T_PLUS   
                | {printf("-");}T_MINUS  
                | {printf("*");}T_TIMES  
                | {printf("/");} T_DIV    
                | {printf("<");}T_LT     
                | {printf("<=");}T_LTEQ   
                | {printf(">");}T_GT     
                | {printf(">=");}T_GTEQ  
                | {printf("==");}T_EQ    
                | {printf("!=");}T_NEQ  
                | {printf("and");}T_AND  
                | {printf("or");}T_OR    
                ;

opunaria        : {printf("-");}T_MINUS
                | {printf("!");}T_NOT
                ;


%%




