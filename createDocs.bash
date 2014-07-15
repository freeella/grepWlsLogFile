#!/usr/bin/bash

pod2man grepWlsLogFile.pl  >docs/man1/grepWlsLogFile.1
pod2html --title="grepWlsLogFile.pl - HELP" --infile=grepWlsLogFile.pl --outfile=docs/index.html
rm pod2htmd.tmp
pod2markdown grepWlsLogFile.pl README.md
