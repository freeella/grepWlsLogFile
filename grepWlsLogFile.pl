#!/usr/bin/perl
use warnings;     # installed by default via perlmodlib
use strict;       # installed by default via perlmodlib
use Getopt::Long qw(:config autoversion); # installed by default via perlmodlib
use Pod::Usage;   # installed by default via perlmodlib

##### START: Documentation in POD format #####
=pod

=head1 NAME

grepWlsLogFile.pl - helps filtering and searching WebLogic Server log files

=head1 SYNOPSIS

C<<< grepWlsLogFile.pl [-f serverName.log]
                 [-l loggerName]
                 [-s severityName]
                 [-m BEA-number] >>>

=head1 OPTIONS

Runtime:

=over 15

=item --file serverName.log   -f serverName.log

Path to WLS server log

=item --logger loggerName   -l loggerName

Filter by logger.

=item --severity severityName   -s severityName

Filter by severity.

=item --msgid message-number   -m message-number

Filter by message id. A WebLogic Server message id usually has the format 
BEA-<6 numbers>. If no prefix is given, BEA- and the missing zeros are 
automatically prepended.

=back

=head1 AUTHORS

Kai Ellinger <coding@blicke.de>

=head1 COPYRIGHT AND LICENSE

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

=cut
##### END: Documentation in POD format #####

my $o_file;
my $o_logger;
my $o_severity;
my $o_msgid;

my $DEBUG = 0;

sub check_args {

	Getopt::Long::Configure ("bundling");

	GetOptions(
		'f:s' => \$o_file,  'file:s'  => \$o_file,
		'l:s' => \$o_logger,  'logger:s'  => \$o_logger,
		's:s' => \$o_severity,  'severity:s'  => \$o_severity,
		'm:s' => \$o_msgid,  'msgid:s'  => \$o_msgid
	);

	# add BEA- if no other prefix was given
	if($o_msgid =~ /^\d+$/) {
		if(length($o_msgid) < 6) {
			my $missingZero = 6 - length($o_msgid);
			$o_msgid = ("0" x $missingZero) . $o_msgid;
		};
		$o_msgid = "BEA-" . $o_msgid;
	}

	### print help if requested
	if (!defined($o_file) || ( !defined($o_logger) && !defined($o_severity) && !defined($o_msgid)) ) {
	   pod2usage(-verbose => 99, -sections => "NAME|SYNOPSIS|OPTIONS");
	   return 0;
	}
	return 1;
}

sub like_to_print {
	# default is not to print
	my $ret_value = 0;
	
	#print "to_parse -@to_parse-";
	foreach my $values ( (shift, shift, shift) ) {
		if($values == 2) {
			# stop if one mismatch was found
			$ret_value = 0;
			last;
		} 
		# continue with print check if one match was found
		# to allow searching for subsequent 2 = mismatch
		elsif ($values eq 1) {
			$ret_value = 1;
		}
	}
	# if only 
	return $ret_value;
}

sub grep_file {
	$DEBUG && print "DEBUG: grep_file() start!\n";
	open(WLSLOG,$o_file) or die "ERROR: Can't open log file '$o_file': $!";
	
	my @line_to_print = (0,0,0);
	
	while(defined(my $logfile_line = <WLSLOG>))
	{
		
		# new log entry
		if($logfile_line =~ /^#{4}/)
		{	
			# reset each new log entry
			@line_to_print = (0,0,0);
			
			# check filters
			# Example line: 
			####<Jul 7, 2014 14:08:10,815 MESZ> <Info> <WorkManager> <kellinge-lnxdsk> <engine1> <[ACTIVE] ExecuteThread: '0' for queue: 'weblogic.kernel.Default (self-tuning)'> <<WLS Kernel>> <> <> <1404734890815> <BEA-002903>
			####<Jul 7, 2014 14:08:11,4 MESZ> <Notice> <WLSS.Engine> <kellinge-lnxdsk> <engine1> <[ACTIVE] ExecuteThread: '0' for queue: 'web...
			$logfile_line =~ /^####<+[^>]*>+\s*<+([^>]*)>+\s*<+([^>]*)>+\s*<+[^>]*>+\s*<+[^>]*>+\s*<+[^>]*>+\s*<+[^>]*>+\s*<+[^>]*>+\s*<+[^>]*>+\s*<+[^>]*>+\s*<+([^>]*)>+/;#<[^>]+>\s*<[^>]+>\s*<[^>]+>\s*<[^>]+>\s*<[^>]+>\s*<([^>]+)>\s*/;
			my $line_severity = $1;
			my $line_logger = $2;
			my $line_msgid = $3;
			
			$DEBUG && print "DEBUG: severity='$line_severity' logger='$line_logger' msgid='$line_msgid'\n";
			# 0 = no search criteria defined = untouched
			# 1 = criteria given and match found
			# 2 = criteria given and mismatch found
			if(defined($o_logger)) {
				if($line_logger eq $o_logger) {
					$line_to_print[0] = 1;
				} else {
					$line_to_print[0] = 2;
				}
			}
			if(defined($o_severity)) {
				if($line_severity eq $o_severity ) {
					$line_to_print[1] = 1;
				} else {
					$line_to_print[1] = 2;
				}
			}
			if(defined($o_msgid)) {
				if($line_msgid eq $o_msgid ) {
					$line_to_print[2] = 1;
				} else {
					$line_to_print[2] = 2;
				}
			}
		}
		
		# print if all is matching
		if(like_to_print($line_to_print[0],$line_to_print[1],$line_to_print[2])) { print $logfile_line; }
	} # END while
	
	close(WLSLOG);
	$DEBUG && print "DEBUG: grep_file() end!\n";
}

#### MAIN
if(check_args) {
	grep_file;
}
