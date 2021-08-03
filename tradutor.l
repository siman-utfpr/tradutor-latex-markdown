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
{DATA} {salvarConteudo(&yylval.conteudo, yytext); return DATA;} 
*/

%}

INICIO \\begin\{document\}

FIM \\end\{document\}

CAPITULO \\chapter

PARAGRAFO \\paragraph

SECAO \\section

SUBSECAO \\subsection

CONTEUDO [a-zA-Z0-9 \n]+

CLASSE \\documentclass(\[.*\])?

PACOTE \\usepackage(\[.*\])?

TITULO \\title

AUTOR  \\author

DATA   \\date

%%

\n {}
{INICIO} {return INICIO;}
{FIM} {return FIM;}
{CAPITULO} {return CAPITULO;}
{SECAO} {return SECAO;}
{SUBSECAO} {return SUBSECAO;}
{PARAGRAFO} {return PARAGRAFO;}
{TITULO} {return TITULO;}
{CLASSE} {return CLASSE;}
{PACOTE} {return PACOTE;}
{AUTOR} {return AUTOR;}
{DATA} {return DATA;}
{CONTEUDO} {salvarConteudo(&yylval.conteudo, yytext); return CONTEUDO;}
"{" |
"}" {return yytext[0];}
. {printf("Não reconhecido: %s\n", yytext); }

%%
