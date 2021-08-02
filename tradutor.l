%option noyywrap
%{
#include "tradutor.h"
#include "tradutor.tab.h"
#include <stdio.h>
#include <stdlib.h>

/* {CLASSE} {salvarConteudo(&yylval.conteudo, yytext); return CLASSE;}
{PACOTE} { salvarConteudo(&yylval.conteudo, yytext); return PACOTE;}
{TITULO} {salvarConteudo(&yylval.conteudo, yytext); return TITULO;}
{AUTOR} {salvarConteudo(&yylval.conteudo, yytext); return AUTOR;}
{DATA} {salvarConteudo(&yylval.conteudo, yytext); return DATA;} */

%}

INICIO \\begin\{document\}

PARAGRAFO \\paragraph

CLASSE \\documentclass(\[.*\])?\{[a-zA-Z]+\}

PACOTE \\usepackage(\[.*\])?\{[a-zA-Z0-9-]+\}

TITULO \\title\{[a-zA-Z0-9" "-]+\}

AUTOR  \\author\{[a-zA-Z0-9" "]+\}

DATA   \\date\{([a-zA-Z" "0-9/-]+)\}

NOME   [a-zA-Z0-9" "]+

CONTEUDO [a-zA-Z0-9" ""\n"]+

%%

{INICIO} {return INICIO;}
{PARAGRAFO} {return PARAGRAFO;}
"{"  |
"}"      {return yytext[0];}
{NOME}     {return NOME;}
{CONTEUDO} {salvarConteudo(&yylval.conteudo, yytext); return CONTEUDO;}
. {printf("Não reconhecido: %s\n", yytext); }

%%
