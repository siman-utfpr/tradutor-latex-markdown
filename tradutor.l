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

{CLASSE} {salvarConteudo(&yylval.conteudo, yytext); return CLASSE;}
{PACOTE} { salvarConteudo(&yylval.conteudo, yytext); return PACOTE;}
{TITULO} {salvarConteudo(&yylval.conteudo, yytext); return TITULO;}
{AUTOR} {salvarConteudo(&yylval.conteudo, yytext); return AUTOR;}
{DATA} {salvarConteudo(&yylval.conteudo, yytext); return DATA;}
. {printf("Não reconhecido: %s\n", yytext); }

%%
