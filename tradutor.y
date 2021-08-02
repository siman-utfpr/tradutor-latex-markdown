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

%token PARAGRAFO
%token <conteudo> INICIO NOME CONTEUDO
//%type <conteudo> classe autores data titulo

%%

documento: inicio texto
  | inicio
  ;

inicio: INICIO {
  printf("Início do documento!!!!\n");
}
  ;

texto: PARAGRAFO '{' CONTEUDO '}' {
  printf("Parágrafo: %s\n", $3);
}
  ;
%%