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
%type <lista> corpoLista capitulo secao subsecao corpo texto
%%

documento: configuracoes principal {  
  $$ = alocarNo("DOCUMENTO", C_NULO);
  inserirNo(&($$), $1, CHILD);
  inserirNo(&($1), $2, PROX);
  FILE *arquivoSaida;
  arquivoSaida = fopen("saida/teste1.md", "w");
  imprimirLista($$, arquivoSaida);
  fclose(arquivoSaida);
}
  ;

configuracoes: classe pacotes titulo autor data {
  $$ = alocarNo("CONFIGURAÇÕES", C_NULO);
  inserirNo(&($$), $1, CHILD);
  inserirNo(&($1), $2, PROX);
  inserirNo(&($2), $3, PROX);
  inserirNo(&($3), $4, PROX);
  inserirNo(&($4), $5, PROX);
}
  ;

classe: CLASSE '{' CONTEUDO '}' { $$ = alocarNo($3, C_CLASSE); }
  ;

pacotes: PACOTE '{' CONTEUDO '}' pacotes { $$ = alocarNo($3, C_PACOTE); inserirNo(&($$), $5, PROX);}
  | PACOTE '{' CONTEUDO '}' {$$ = alocarNo($3, C_PACOTE); }
  ;

titulo: TITULO '{' CONTEUDO '}' { $$ = alocarNo($3, C_TITULO);}
  ;

autor: AUTOR '{' CONTEUDO '}' { $$ = alocarNo($3, C_AUTOR);}
  ;

data: DATA '{' CONTEUDO '}' { $$ = alocarNo($3, C_DATA);}
  ;

principal: INICIO corpoLista FIM {
  $$ = alocarNo("PRINCIPAL: ", C_NULO);
  inserirNo(&($$), $2, CHILD);
  }
  ;

corpoLista:  {$$ = NULL; }
  | capitulo corpoLista{ 
    $$ = alocarNo("CORPO LISTA: ", C_NULO); 
    inserirNo(&($$), $1, CHILD); 
    //inserirNo(&($1), $2, CHILD);
    //inserirNo(&($2), $3, CHILD);
    inserirNo(&($$), $2, PROX);
  }
  | corpo {inserirNo(&($$), $1, CHILD);}
  ;

capitulo: CAPITULO '{' CONTEUDO '}' corpo secao { 
    $$ = alocarNo($3, C_CAPITULO); 
    inserirNo(&($$), $5, CHILD);
    inserirNo(&($5), $6, PROX); 
    }
  | CAPITULO '{' CONTEUDO '}' secao {$$ = alocarNo($3, C_CAPITULO); inserirNo(&($$), $5, CHILD);}
  ;

secao: {$$ = NULL;}
  | SECAO '{' CONTEUDO '}' corpo subsecao secao{
    $$ = alocarNo($3, C_SECAO); 
    inserirNo(&($$), $5, CHILD);
    inserirNo(&($5), $6, PROX); 
    inserirNo(&($$), $7, PROX); 
    }
  | SECAO '{' CONTEUDO '}' subsecao secao {
    $$ = alocarNo($3, C_SECAO);
    inserirNo(&($$), $5, CHILD);
    inserirNo(&($$), $6, PROX);
    }
  ;

subsecao: {$$ = NULL;}
  | SUBSECAO '{' CONTEUDO '}' corpo subsecao {
    $$ = alocarNo($3, C_SUBSECAO);
    inserirNo(&($$), $6, PROX);
    inserirNo(&($$), $5, CHILD); 
    }
  ;

corpo: texto {$$ = alocarNo("CORPO: ", C_NULO); inserirNo(&($$), $1, CHILD);}
  | texto corpo {$$ = alocarNo("CORPO: ", C_NULO); inserirNo(&($$), $1, CHILD); inserirNo(&($$), $2, PROX); }
  ;

texto: PARAGRAFO '{' CONTEUDO '}' { $$ = alocarNo($3, C_PARAGRAFO);}
  ;
%%