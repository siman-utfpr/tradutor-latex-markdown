%option noyywrap
%{
#include "tradutor.h"
#include "tradutor.tab.h"
#include <stdio.h>
#include <stdlib.h>

%}

INICIO \\begin\{document\}

FIM \\end\{document\}

INICIOLISTAUL \\begin\{itemize\}

FIMLISTAUL \\end\{itemize\}

INICIOLISTAOL \\begin\{enumerate\}

FIMLISTAOL \\end\{enumerate\}

CAPITULO \\chapter

PARAGRAFO \\paragraph

SECAO \\section

SUBSECAO \\subsection

NEGRITO \\textbf

ITALICO \\textit

ITEM \\item

CONTEUDO [a-zA-Z0-9 \n]+

CLASSE \\documentclass(\[.*\])?

PACOTE \\usepackage(\[.*\])?

TITULO \\title

AUTOR  \\author

DATA   \\date

%%
[\t\n] 
{INICIO} {return INICIO;}
{FIM} {return FIM;}
{INICIOLISTAUL} {return INICIOLISTAUL;}
{FIMLISTAUL} {return FIMLISTAUL;}
{INICIOLISTAOL} {return INICIOLISTAOL;}
{FIMLISTAOL} {return FIMLISTAOL;}
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
{NEGRITO} {return NEGRITO;}
{ITALICO} {return ITALICO;}
{DATA} {return DATA;}
{ITEM} {return ITEM;}
{CONTEUDO} {salvarConteudo(&yylval.conteudo, yytext); return CONTEUDO;}
"{" |
"}" {return yytext[0];}
. {printf("Não reconhecido: %s\n", yytext); }

%%
