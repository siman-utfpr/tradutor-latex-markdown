%{
#include "tradutor.h"
#include <stdio.h>
#include <stdlib.h>

int yylex();
%}

%union{
  char *tag; 
  char *conteudo;
}

%token PACOTE

%%

pacote: 
  ;

%%