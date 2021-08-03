#define CHILD 1
#define PROX 2

struct No {
  char *value;
  struct No *child;
  struct No *prox;
};

typedef struct No No;

extern int yylineno;

No *alocarNo(char *);

void inserirNo(No **, No *, int);

void imprimirLista(No *);

/*
  Separa o conteúdo de uma tag do texto completo 
*/
char *
extrairConteudo(char *);

/*
  Função auxiliar do Lexer que inclui o valor filtrado de cada lexema em yylval
*/
void salvarConteudo(char **, char *);

void yyerror(char *s, ...);