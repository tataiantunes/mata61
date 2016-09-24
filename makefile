#parser analyser maker
all: lex.yy.c y.tab.c
	gcc -g lex.yy.c y.tab.c -o sintatico

lex.yy.c: y.tab.c lexical.l
	flex lexical.l

y.tab.c: sintatico.y
	yacc -d sintatico.y

clean: 
	rm -f lex.yy.c y.tab.c y.tab.h sintatico
