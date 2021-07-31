%{
#include "tradutor.h"
#include <stdio.h>
#include <stdlib.h>

int yylex();
int numeroPacotes = 0;
int numeroAutores = 0;
%}

%union{
  char *conteudo;
}

%token <conteudo> PACOTE AUTOR DATA TITULO CLASSE
%type <conteudo> classe autores data titulo

%start metadados
%%

pacotes: {printf("Lista de pacotes utilizados: "); }
  | pacotes PACOTE{
  printf("    Nome do pacote: %s", $2);
  }
  ;

classe: 
  | CLASSE {printf("Classe = %s\n", $1);}
  ;

autores: {printf("Lista de autores: "); }
  | autores AUTOR { printf("    Nome do autor: %s", $2);}
  ;

data: 
  | DATA {printf("Data = %s\n", $1);}
  ;

titulo:
  | TITULO {printf("Título = %s\n", $1);}
  ;

metadados: 
  | classe pacotes titulo autores data {
  
  }
  ;
%%