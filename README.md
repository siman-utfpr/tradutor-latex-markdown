# tradutor-latex-markdown
Implementação de um tradutor entre LaTex e Markdown utilizando análise sintática e léxica

## Referências
[Tutorial de criação de um arquivo LaTex - Overleaf](https://pt.overleaf.com/learn/latex/Creating_a_document_in_LaTeX)


## Relação de Elementos

class - não relaciona com nada, mas adiciona ao final do arquivo.

packages - não relaciona com nada, mas adiciona ao final do arquivo.

author - não relaciona com nada, mas adiciona ao final do arquivo.

date - não relaciona com nada, mas adiciona ao final do arquivo, junto do autor.

maketitle - ignora.


thanks - ignora.

title - maior header - \#
  
\\\\ - nova linha

section{} / chapter - 

\par = novo parágrafo = \n e uma tabulação

### begin{...}

begin{comment} / comment (%) - ignora a tag e o conteúdo.

Orientação de texto: ignora e copia o texto
* center
* flushleft
* flushright


document - A gente não relaciona com nada, mas usa como limite pro corpo do 
  documento no parser. 

\\... - ignora.
