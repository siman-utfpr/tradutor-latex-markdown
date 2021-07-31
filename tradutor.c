#include "tradutor.h"

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
  fprintf(stderr, "%d: error: ", yylineno);
  fprintf(stderr, "\n");
}
