#!/usr/bin/env perl

$pdf_mode         = 3;
$latex            = 'lualatex %O --shell-escape -synctex=1 %S ';
$bibtex           = 'upbibtex %O %B -kanji=utf8';
# $dvipdf           = 'dvipdfmx %O -o %D %S';
$makeindex        = 'mendex %O -o %D %S';
$do_cd            = 1;