# lexical analyser maker

all:
	flex lexical.l
	gcc lex.yy.c
	#Altere *.lua e *.txt conforme sua necessidade
	./a.out hello.lua saida.txt

clean:
	$(RM) saida.txt