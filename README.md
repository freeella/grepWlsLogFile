# NAME

grepWlsLogFile.pl - helps filtering and searching WebLogic Server log files

# SYNOPSIS

`grepWlsLogFile.pl [-f serverName.log]
                 [-l loggerName]
                 [-s severityName]
                 [-m BEA-number]
                 [-t jta-transaction]
                 [-c "search text"]
                 [--help]
                 [--version]
                 [--debug]>>>`

# OPTIONS

- \--file serverName.log   -f serverName.log

    Path to WLS server log

- \--logger loggerName   -l loggerName

    Filter by logger.

- \--severity severityName   -s severityName

    Filter by severity.

- \--msgid message-number   -m message-number

    Filter by message id. A WebLogic Server message id usually has the format 
    BEA-<6 numbers>. If no prefix is given, BEA- and the missing zeros are 
    automatically prepended.

- \--tranid jta-transaction   -t jta-transaction

    In case a log message is created out of a JTA transaction context, 
    the transaction id is logged as well.

    This transaction id can be used as search criteria.

- \--content 'search text'   -c 'search text'

    Us a Perl style regular expression to search the free text part of the log message.

    Regex example: Lines containing 'managed1' and 'maXaged3' will be printed but not 'managed2' or 'Managed3'

    `./grepWlsLogFile.pl -f /path/to/AdminServer.log -c 'ma.ag\Sd[31]'`

- \--help   -?

    Showing help screen

- \--version

    Showing version info

- \--debug

    Enabling debug

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
