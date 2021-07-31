%{
#include "tradutor.h"
#include <stdio.h>
#include <stdlib.h>

int yylex();
%}

%union{
  char *conteudo;
}

%token <conteudo> PACOTE AUTOR DATA TITULO CLASSE

%%

pacotes: 
  | pacotes PACOTE{
  printf("Nome do pacote: %s\n", $2);
}
  ;



%%