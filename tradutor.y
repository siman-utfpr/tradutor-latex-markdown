%{
#include "tradutor.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
%}

%union{
  char *conteudo;
}

%token PARAGRAFO TITULO INICIO FIM CAPITULO SECAO SUBSECAO
%token <conteudo>  CONTEUDO
%start documento

%type <conteudo> secao capitulo subsecao corpo texto
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

corpoLista: 
  | capitulo secao subsecao corpoLista {printf("%s\n--%s\n----%s\n", $1, $2, $3);}
  | corpo 
  ;

capitulo: 
 | CAPITULO '{' CONTEUDO '}' corpo capitulo {$$ = $3; strcat($$, "\n"); strcat($$, $5);}
 | CAPITULO '{' CONTEUDO '}'
 ;

secao: {$$ = "";}
  | SECAO '{' CONTEUDO '}' corpo secao { $$ = $3; strcat($$, "\n"); strcat($$, $5);}
  | corpo
  ;

subsecao: {$$ = "";}
  | SUBSECAO '{'CONTEUDO '}' corpo subsecao { $$ = $3; strcat($$, "\n"); strcat($$, $5);}
  | corpo subsecao {}
  ;

corpo: texto {$$ = $1;}
 | texto corpo {strcat($$, "\n");strcat($$, $2);}
 ;

texto: PARAGRAFO '{' CONTEUDO '}' {
  $$ = $3;
  //printf("Parágrafo: %s\n", $3);
}
  ;

fim: FIM  {
  printf("Fim do documento!\n");
}
  ;
%%