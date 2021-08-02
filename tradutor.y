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

%token PARAGRAFO TITULO INICIO FIM CAPITULO SECAO SUBSECAO
%token <conteudo>  CONTEUDO
%start documento
%%

documento: configuracoes principal
  ;

configuracoes: titulo
  ;

titulo: TITULO '{' CONTEUDO '}' {
  printf("Título encontrado: %s\n", $3);
}
  ;

principal: inicio corpoLista fim
  ;

inicio: INICIO {
  printf("Início do documento!\n");
}
  ;

corpoLista: capitulo secao subsecao corpoLista
  | corpo
  ;

capitulo: CAPITULO '{' CONTEUDO '}' corpo capitulo {printf("##%s\n", $3);}
 | CAPITULO '{' CONTEUDO '}' {printf("##%s\n", $3);}
 ;

secao: SECAO '{' CONTEUDO '}' corpo secao {printf("###%s\n", $3);}
  | corpo  {printf("seção\n");}
  ;

subsecao: SUBSECAO '{'CONTEUDO '}' corpo subsecao {printf("####%s\n", $3);}
  | corpo 
  ;

corpo: texto
 | texto corpo
 ;

texto: PARAGRAFO '{' CONTEUDO '}' {
  printf("Parágrafo: %s\n", $3);
}
  ;

fim: FIM  {
  printf("Fim do documento!\n");
}
  ;
%%