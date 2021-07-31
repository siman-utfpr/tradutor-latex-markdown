#include "tradutor.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv[]) {
  FILE* arquivoEntrada;
  arquivoEntrada = fopen(argv[1], "r");
  yyrestart(arquivoEntrada);
  yylex();
  return 0;
}
