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

NOME   [a-zA-Z0-9" "]+

CONTEUDO [a-zA-Z0-9" ""\n"]+


%%

{CLASSE} {salvarConteudo(&yylval.conteudo, yytext); return CLASSE;}
{PACOTE} { salvarConteudo(&yylval.conteudo, yytext); return PACOTE;}
{TITULO} {salvarConteudo(&yylval.conteudo, yytext); return TITULO;}
{AUTOR} {salvarConteudo(&yylval.conteudo, yytext); return AUTOR;}
{DATA} {salvarConteudo(&yylval.conteudo, yytext); return DATA;}
"\begin"      |
"\end"        |
"{"           |
"}"           |
"\chapter"    |
"\section"    |
"\subsection" |
"\paragraph"  |
"\bf"         |
"\underline"  |
"\it"         |
"enumerate"   |
"document"    |
"itemize"     |
"\item"       {return yytext;}
{NOME}     {return NOME;}
{CONTEUDO} {return CONTEUDO;}
. {printf("Não reconhecido: %s\n", yytext); }

%%
