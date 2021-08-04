#include <stdio.h>
#include <stdlib.h>
#define CHILD 1
#define PROX 2

#define C_NULO 0
#define C_CAPITULO 1
#define C_SECAO 2
#define C_SUBSECAO 3
#define C_PARAGRAFO 4
#define C_NEGRITO 5
#define C_ITALICO 6
#define C_LISTAUL 7
#define C_LISTAOL 8
#define C_CLASSE 9
#define C_PACOTE 10
#define C_AUTOR 11
#define C_DATA 12
#define C_TITULO 13
#define C_TEXTO 14

struct No {
  char *value;
  struct No *child;
  struct No *prox;
  int tipo;
  int numeroEspacos;
};

typedef struct No No;

extern int yylineno;

No *alocarNo(char *, int tipo);

void inserirNo(No **, No *, int);

void imprimirLista(No *, FILE *);

/*
  Função auxiliar do Lexer que inclui o valor filtrado de cada lexema em yylval
*/
void salvarConteudo(char **, char *);

void yyerror(char *s, ...);

void inserirEspacosLista(No **no, int numeroEspacos);

void impressaoSecundaria(No *no);