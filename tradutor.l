%option noyywrap
%{
%}

CLASSE \\documentclass\{[a-zA-Z]+\}

PACOTE \\usepackage(\[.*\])?\{[a-zA-Z0-9-]+\}

%%

{CLASSE} {printf("Classe: %s\n", yytext);}
{PACOTE} {printf("Pacote: %s\n", yytext);}
. {printf("Não reconhecido: %s\n", yytext);}

%%

int main(){
  yylex();
  return 0;
}