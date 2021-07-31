tradutor: tradutor.l
	flex -o tradutor.lex.c tradutor.l 
	gcc tradutor.lex.c -lfl -o tradutor
	@echo Concluído...