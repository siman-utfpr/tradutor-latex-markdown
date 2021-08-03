%{
#include "tradutor.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
%}

%union{
  struct No *lista;
  char *conteudo;
}

%token TITULO CLASSE PACOTE AUTOR DATA
%token INICIO FIM CAPITULO SECAO SUBSECAO PARAGRAFO
%token <conteudo>  CONTEUDO
%start documento

// %type <conteudo> secao capitulo subsecao corpo texto corpoLista
%type <lista> documento configuracoes principal titulo classe pacotes autor data
%type <lista> corpoLista capitulo corpo texto
%%

documento: configuracoes principal {  
  $$ = alocarNo("DOCUMENTO");
  inserirNo(&($$), $1, CHILD);
  inserirNo(&($1), $2, PROX);
  imprimirLista($$);
}
  ;

configuracoes: classe pacotes titulo autor data {
  $$ = alocarNo("CONFIGURAÇÕES");
  inserirNo(&($$), $1, CHILD);
  inserirNo(&($1), $2, PROX);
  inserirNo(&($2), $3, PROX);
  inserirNo(&($3), $4, PROX);
  inserirNo(&($4), $5, PROX);
}
  ;

classe: CLASSE '{' CONTEUDO '}' { $$ = alocarNo($3); }
  ;

pacotes: PACOTE '{' CONTEUDO '}' pacotes { $$ = alocarNo($3); inserirNo(&($$), $5, PROX);}
  | PACOTE '{' CONTEUDO '}' {$$ = alocarNo($3); }
  ;

titulo: TITULO '{' CONTEUDO '}' { $$ = alocarNo($3);}
  ;

autor: AUTOR '{' CONTEUDO '}' { $$ = alocarNo($3);}
  ;

data: DATA '{' CONTEUDO '}' { $$ = alocarNo($3);}
  ;

principal: INICIO corpoLista FIM {
  $$ = alocarNo("PRINCIPAL: ");
  inserirNo(&($$), $2, CHILD);
  }
  ;

corpoLista: capitulo { $$ = alocarNo("CORPO LISTA: "); inserirNo(&($$), $1, CHILD);}
  | corpo
  ;

capitulo: CAPITULO '{' CONTEUDO '}' corpo {$$ = alocarNo($3); inserirNo(&($$), $5, CHILD); }
  ;

corpo: texto {$$ = alocarNo("CORPO: "); inserirNo(&($$), $1, CHILD);}
  | texto corpo {$$ = alocarNo("CORPO: "); inserirNo(&($$), $1, CHILD); inserirNo(&($$), $2, PROX); }
  ;

texto: PARAGRAFO '{' CONTEUDO '}' { $$ = alocarNo($3);}
  ;
/*
secao: {strcat($$, "");}
  | SECAO '{' CONTEUDO '}' corpo { strcpy($$, "###"); strcat($$, $3);strcat($$, "\n");}
  | corpo
  ;

subsecao: {strcat($$, "");}
  | SUBSECAO '{'CONTEUDO '}' corpo {strcpy($$, "####"); strcat($$, $3);strcat($$, "\n");}
  ;

corpo: texto {$$ = $1;}
 | texto corpo {strcat($$, $1);}
 ;

texto: PARAGRAFO '{' CONTEUDO '}' { //strcpy($$, $3);
$$ = $3;
}
  ;
  */
%%