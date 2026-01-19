#!/bin/bash


FILENAME=$1

flex $FILENAME

cc lex.yy.c -ll

./a.out
