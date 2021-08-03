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

char* extrairConteudo(char* entrada) {
  char* resultado = strtok(entrada, "{");
  char* resultadoFiltrado = malloc(sizeof entrada);
  resultado = strtok(NULL, "{");
  strncpy(resultadoFiltrado, resultado, strlen(resultado) - 1);
  //printf("Resultado filtrado: %s\n", resultadoFiltrado);
  return resultadoFiltrado;
}

void salvarConteudo(char** yylval, char* yytext) {
  *yylval = strdup(yytext);
  strcpy(*yylval, yytext);
}

No* alocarNo(char* valor) {
  No* novoNo = (No*)malloc(sizeof(struct No));
  novoNo->child = NULL;
  novoNo->prox = NULL;
  novoNo->value = malloc(sizeof valor);
  strcat(novoNo->value, valor);
  if (novoNo == NULL) {
    yyerror("Erro de alocação.");
  }
  return novoNo;
}

void inserirNo(No** no, No* noInserido, int tipo) {
  if (tipo == CHILD) {
    (*no)->child = noInserido;
  } else {
    No* noAux = (*no);
    while (noAux->prox != NULL) {
      noAux = noAux->prox;
    }
    noAux->prox = noInserido;
  }
}

void imprimirLista(No* no) {
  while (no != NULL) {
    printf("Valor do nó: %s\n", no->value);
    imprimirLista(no->child);
    no = no->prox;
  }
}
