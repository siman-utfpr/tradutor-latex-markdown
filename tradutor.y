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
%token INICIO FIM CAPITULO SECAO SUBSECAO PARAGRAFO NEGRITO ITALICO 
%token ITEM INICIOLISTAUL INICIOLISTAOL FIMLISTAUL FIMLISTAOL
%token <conteudo>  CONTEUDO
%start documento

%type <lista> documento configuracoes identificacao principal titulo classe pacotes autor data
%type <lista> corpoLista capitulo secao subsecao corpo texto textoEstilo 
%type <lista> listas listaUL listaOL
%%

documento: configuracoes identificacao principal {  
  FILE *arquivoSaida;
  arquivoSaida = fopen("saida/teste1.md", "w");
  imprimirLista($2, arquivoSaida);
  imprimirLista($3, arquivoSaida);
  imprimirLista(alocarNo("\n***\n", C_TEXTO), arquivoSaida);
  imprimirLista($1, arquivoSaida);
  fclose(arquivoSaida);
}
  ;

configuracoes: classe pacotes {
  $$ = alocarNo("Configurações do arquivo Latex", C_NEGRITO);
  inserirNo(&($$), $1, CHILD);
  inserirNo(&($1), $2, PROX);
}
  ;

identificacao: autor data titulo {
  $$ = alocarNo("Identificação", C_ITALICO);     
  inserirNo(&($$), $1, CHILD);
  inserirNo(&($1), $2, PROX);
  inserirNo(&($2), $3, PROX);
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
  $$ = alocarNo("", C_NULO);
  inserirNo(&($$), $2, CHILD);
  }
  ;

corpoLista:  {$$ = NULL; }
  | capitulo corpoLista{ 
    $$ = alocarNo("", C_NULO); 
    inserirNo(&($$), $1, CHILD); 
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

corpo: texto {$$ = alocarNo("", C_NULO); inserirNo(&($$), $1, CHILD);}
  | texto corpo {$$ = alocarNo("", C_NULO); inserirNo(&($$), $1, CHILD); inserirNo(&($$), $2, PROX); }
  | listas corpo {
    $$ = alocarNo("", C_NULO); 
    inserirNo(&($$), $1, CHILD);    
    inserirNo(&($$), $2, PROX);
    inserirEspacosLista(&($1->child), 0);
    }
  ;

texto: {$$ = NULL;}
  | CONTEUDO texto { $$ = alocarNo($1, C_TEXTO); inserirNo(&($$), $2, PROX); }
  | PARAGRAFO '{' texto '}' { $$ = alocarNo("", C_PARAGRAFO); inserirNo(&($$), $3, CHILD); }
  | textoEstilo '{' CONTEUDO '}' texto { $$ = alocarNo($3, $1->tipo); inserirNo(&($$), $5, PROX);}
  ;

textoEstilo: NEGRITO {$$ = alocarNo("", C_NEGRITO);  }
  | ITALICO {$$ = alocarNo("", C_ITALICO);}
  ;

listas: INICIOLISTAOL listaOL FIMLISTAOL {
  $$ = alocarNo("", C_NULO);
  inserirNo(&($$), $2, CHILD);
  }
  | INICIOLISTAUL listaUL FIMLISTAUL {
    $$ = alocarNo("", C_NULO);
    inserirNo(&($$), $2, CHILD);
  }
  ;

listaOL: ITEM '{' CONTEUDO '}' { $$ = alocarNo($3, C_LISTAOL);  }
  | ITEM '{' CONTEUDO '}' listaOL {
    $$ = alocarNo($3, C_LISTAOL);
    inserirNo(&($$), $5, PROX);
  }
  | listas { $$ = $1;  }
  | listas listaOL {
    $$ = $1;   
    inserirNo(&($1), $2, PROX);  
  }
  ;

listaUL: ITEM '{' CONTEUDO '}' { $$ = alocarNo($3, C_LISTAUL);  }
  | ITEM '{' CONTEUDO '}' listaUL {
    $$ = alocarNo($3, C_LISTAUL);
    inserirNo(&($$), $5, PROX);
  }
  | listas { $$ = $1;  }
  | listas listaUL {
    $$ = $1;   
    inserirNo(&($1), $2, PROX);  
  }
  ;
;
%%