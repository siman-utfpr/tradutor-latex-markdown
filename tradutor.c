#include "tradutor.h"

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yyparse();
int yyrestart();

int main(int argc, char* argv[]) {
  FILE* arquivoEntrada;
  arquivoEntrada = fopen(argv[1], "r");
  yyrestart(arquivoEntrada);
  return yyparse();
  return 0;
}

void yyerror(char* s, ...) {
  va_list ap;
  va_start(ap, s);

  fprintf(stderr, "%d: error: ", yylineno);
  vfprintf(stderr, s, ap);
  fprintf(stderr, "\n");
}

void salvarConteudo(char** yylval, char* yytext) {
  *yylval = strdup(yytext);
  strcpy(*yylval, yytext);
}

No* alocarNo(char* valor, int tipo) {
  No* novoNo = malloc(sizeof(struct No));
  novoNo->child = NULL;
  novoNo->prox = NULL;
  novoNo->tipo = tipo;
  novoNo->value = malloc(strlen(valor));
  strcpy(novoNo->value, valor);
  if (novoNo == NULL) {
    yyerror("Erro de alocação.");
  }
  return novoNo;
}

void inserirNo(No** no, No* noInserido, int tipo) {
  if (*no == NULL) return;
  if (tipo == CHILD && (*no)->child == NULL) {
    (*no)->child = noInserido;
  } else {
    No* noAux = (*no);
    while (noAux->prox != NULL) {
      noAux = noAux->prox;
    }
    noAux->prox = noInserido;
  }
}

void imprimirLista(No* no, FILE* arquivoSaida) {
  while (no != NULL) {
    switch (no->tipo) {
      case C_TITULO:
        fprintf(arquivoSaida, "# %s\n", no->value);
        break;
      case C_AUTOR:
        fprintf(arquivoSaida, "Autor do texto: %s\n", no->value);
        break;
      case C_PARAGRAFO:
        fprintf(arquivoSaida, "   %s\n", no->value);
        break;
      case C_CAPITULO:
        fprintf(arquivoSaida, "## %s\n", no->value);
        break;
      case C_SECAO:
        fprintf(arquivoSaida, "### %s\n", no->value);
        break;
      case C_SUBSECAO:
        //printf("Valor subseção: %s\n", no->value);
        fprintf(arquivoSaida, "#### %s\n", no->value);
        break;
      default:
        //printf("Ignorado: %s\n", no->value);
        break;
    }
    //printf("Valor do nó: %s\n", no->value);
    imprimirLista(no->child, arquivoSaida);
    no = no->prox;
  }
}
