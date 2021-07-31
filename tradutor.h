extern int yylineno;

/*
  Separa o conteúdo de uma tag do texto completo 
*/
char *extrairConteudo(char *);

/*
  Função auxiliar do Lexer que inclui o valor filtrado de cada lexema em yylval
*/
void salvarConteudo(char **, char *);

void yyerror(char *s, ...);