#!/usr/bin/bash

pod2man grepWlsLogFile.pl  >grepWlsLogFile.1.man
pod2markdown grepWlsLogFile.pl README.md
