# NAME

grepWlsLogFile.pl - helps searching WLS log files

# SYNOPSIS

`grepWlsLogFile.pl [-f serverName.log]
                 [-l loggerName]
                 [-s severityName]
                 [-m BEA-number]`

# OPTIONS

Runtime:

- \--file serverName.log   -f serverName.log

    Path to WLS server log

- \--logger loggerName   -l loggerName

    Filter by logger.

- \--severity severityName   -s severityName

    Filter by severity.

- \--msgid BEA-number   -m BEA-number

    Filter by message id.

# AUTHORS

Kai Ellinger <coding@blicke.de>

# COPYRIGHT AND LICENSE

The MIT License (MIT)

Copyright 2014 by Kai Ellinger <coding@blicke.de>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
