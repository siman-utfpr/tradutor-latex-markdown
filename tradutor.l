%option noyywrap
%{
#include "tradutor.h"
#include "tradutor.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

CLASSE \\documentclass(\[.*\])?\{[a-zA-Z]+\}

PACOTE \\usepackage(\[.*\])?\{[a-zA-Z0-9-]+\}

TITULO \\title\{[a-zA-Z0-9" "-]+\}

AUTOR  \\author\{[a-zA-Z0-9" "]+\}

DATA   \\date\{([a-zA-Z" "0-9/-]+)\}

%%

{CLASSE} {printf("Classe: %s\n", yytext);}
{PACOTE} {yylval.conteudo = strdup(yytext); strcpy(yylval.conteudo, extrairConteudo(yytext)); return PACOTE;}
{TITULO} {printf("Titulo: %s\n", yytext);}
{AUTOR} {printf("Autor: %s\n", yytext);}
{DATA} {printf("Data: %s\n", yytext);}
. {printf("Não reconhecido: %s\n", yytext); }

%%