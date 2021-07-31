%option noyywrap
%{
%}

CLASSE \\documentclass\{[a-zA-Z]+\}

PACOTE \\usepackage(\[.*\])?\{[a-zA-Z0-9-]+\}

TITULO \\title\{[a-zA-Z0-9" "-]+\}

AUTOR  \\author\{[a-zA-Z0-9" "]+\}

DATA   \\date\{([a-zA-Z" "0-9/-]+)\}

%%

{CLASSE} {printf("Classe: %s\n", yytext);}
{PACOTE} {printf("Pacote: %s\n", yytext);}
{TITULO} {printf("Titulo: %s\n", yytext);}
{AUTOR} {printf("Autor: %s\n", yytext);}
{DATA} {printf("Data: %s\n", yytext);}
. {printf("Não reconhecido: %s\n", yytext);}

%%

int main(){
  yylex();
  return 0;
}