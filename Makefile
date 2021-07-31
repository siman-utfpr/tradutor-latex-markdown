tradutor: tradutor.l tradutor.y tradutor.h tradutor.c
	bison -d tradutor.y -o tradutor.tab.c
	flex -o tradutor.lex.c tradutor.l 
	gcc tradutor.tab.c tradutor.lex.c tradutor.c -lfl -o $@
	@echo Concluído...