tradutor: tradutor.l tradutor.y tradutor.h
	bison -o tradutor.tab.c -d tradutor.y 
	flex -o tradutor.lex.c tradutor.l 
	gcc tradutor.tab.c tradutor.lex.c tradutor.c -lfl -o $@
	@echo Concluído...