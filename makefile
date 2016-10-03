# lexical analyser maker

all:
	yacc -d sintatico.y
	flex lexical.l
	gcc lex.yy.c y.tab.c -o compilador
	#Descomente e altere conforme necessidade
	#./compilador [entrada] [saida]
	#./compilador hello.lua saida.txt
	

clean:
	$(RM) saida.txt
