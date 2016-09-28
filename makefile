#parser analyser maker
all: yacc -d sint_mud.y
	 flex lexical.l
	 gcc -g lex.yy.c y.tab.c -o compilador

#Rode a entrada usando ./compilador < arquivoentrada
#Saida no terminal

clean: 
	rm -f lex.yy.c y.tab.c y.tab.h compilador
