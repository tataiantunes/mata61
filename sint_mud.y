%{
    /* Alunas: Andressa Andrade e Renata Antunes
       Classes possíveis para os tokens da linguagem:
       T_NAME, T_NUMBER,T_AND, T_NOT, T_OR, T_ELSEIF, T_WHILE, T_DO, T_FUNCTION,
       T_END, T_FOR, T_ELSE, T_IF, T_THEN, T_RETURN, T_LOCAL, T_NIL, T_PLUS, T_MINUS,
       T_TIMES, T_DIV, T_COMMA, T_OPENPAR, T_CLOSEPAR, T_SEMICOL, T_ASSIGN,T_EQ, T_NEQ,
       T_LTEQ, T_GTEQ, T_LT, T_GT
    */
    #include <stdio.h>
    #include <stdlib.h>

    //ParserTree
    #define NOTHING -1
    /* Define the Object Structure for a tree node to store
   the compiled result */

    struct treeNode
    {
        int  item;
        int  nodeIdentifier;
        struct treeNode *first;
        struct treeNode *second;
    };

    typedef struct treeNode TREE_NODE;
    typedef TREE_NODE       *BINARY_TREE;

    /* define method templates for functions that build and use trees */
    int evaluate(BINARY_TREE);
    BINARY_TREE create_node(int,int,BINARY_TREE,BINARY_TREE);

    void yyerror (const char *str);
    extern int yylex();
    extern int yylineno;
    extern FILE *yyin;
    extern FILE *yyout;

%}

%start program;

%token<iVal> T_OPENPAR T_CLOSEPAR T_COMMA T_SEMICOL T_ASSIGN T_NUMBER T_DO T_ELSE T_ELSEIF T_END T_FOR T_FUNCTION T_IF T_LOCAL T_NIL T_NOT T_RETURN T_THEN T_WHILE T_NAME
%left<iVal>   T_LT T_GT T_EQ  T_NEQ T_LTEQ T_GTEQ 
%left<iVal>   T_PLUS T_MINUS
%left<iVal>   T_TIMES T_DIV
%left<iVal>    T_AND T_OR

%type<tVal>  program bloco comando elseifthen comandoret exp expbin termos chamadadefuncao listadenomes virgulanomes opbin opunaria listaexp
 

%%
/* Sintaxe da Linguagem */

program         : bloco
                { BINARY_TREE ParseTree; int result;
                ParseTree = create_node(NOTHING,NOTHING,$1,NULL);
                result = evaluate(ParseTree);
                printf("value : %d\n", result);
                }
                ;

bloco           : 
                | comando bloco 
                | comandoret
                ;

comando         : T_SEMICOL
		        | listadenomes T_ASSIGN listaexp
		        | chamadadefuncao
		        | T_DO bloco T_END
		        | T_WHILE exp T_DO bloco T_END
		        | T_FOR T_NAME T_ASSIGN exp T_COMMA exp T_DO bloco T_END
		        | T_FOR T_NAME T_ASSIGN exp T_COMMA exp T_COMMA exp T_DO bloco T_END
		        | T_IF exp T_THEN bloco elseifthen  T_END
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
                | expbin termos opbin { $$ = create_node(NOTHING,opbin,$1,$3); }
                ;

termos          : T_NUMBER { $$ = create_node($1,NUMBER,NULL,NULL); }
                | T_NAME 
                | T_NIL
                | chamadadefuncao
                ;

chamadadefuncao : T_NAME T_OPENPAR T_CLOSEPAR
                | T_NAME T_OPENPAR listaexp T_CLOSEPAR
                ;

listadenomes    : T_NAME virgulanomes
                ;

virgulanomes    : 
                | T_COMMA T_NAME virgulanomes
                ;

listaexp        : exp virgulaexp { $$ = create_node(NOTHING,EXPR,$1,NULL); }
                ;

virgulaexp      : 
                | T_COMMA exp virgulaexp 
                ;

opbin           : T_PLUS  { $$ = create_node($1,T_PLUS,NULL,NULL); }
                | T_MINUS { $$ = create_node($1,T_MINUS,NULL,NULL); }
                | T_TIMES { $$ = create_node($1,T_TIMES,NULL,NULL); }
                | T_DIV   { $$ = create_node($1,T_DIV,NULL,NULL); }
                | T_LT    { $$ = create_node($1,T_LT,NULL,NULL); }
                | T_LTEQ  { $$ = create_node($1,T_LTEQ,NULL,NULL); }
                | T_GT    { $$ = create_node($1,T_GT,NULL,NULL); }
                | T_GTEQ  { $$ = create_node($1,T_GTEQ,NULL,NULL); }
                | T_EQ    { $$ = create_node($1,T_EQ,NULL,NULL); }
                | T_NEQ   { $$ = create_node($1,T_NEQ,NULL,NULL); }
                | T_AND   { $$ = create_node($1,T_AND,NULL,NULL); }
                | T_OR    { $$ = create_node($1,T_OR,NULL,NULL); }
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

