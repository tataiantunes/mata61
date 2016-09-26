#parser analyser maker
all: lex.yy.c y.tab.c
	gcc -g lex.yy.c y.tab.c -o compilador

lex.yy.c: y.tab.c lexical.l
	flex lexical.l

y.tab.c: sint_mud.y
	yacc -d sint_mud.y

clean: 
	rm -f lex.yy.c y.tab.c y.tab.h compilador
