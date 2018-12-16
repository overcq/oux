#!/bin/sh
################################################################################
#   ___   publicplace
#  ¦OUX¦  “sh”
#  ¦Inc¦  compile
#   ---   ‟Coux”
#         “.cx” to “.h” utility for system headers
# ©overcq                on ‟Gentoo Linux 17.0” “x86_64”            2018‒11‒12 b
################################################################################
headers_db="$1"
cx_source="$2"
#===============================================================================
perl -we '
    use warnings;
    local $/;
    open my $file, "'"$cx_source"'";
    my $cnt = <$file>;
    close $file;
    local $/ = "\n";
    while(<>)
    {   chomp;
        @line = split;
        $func = shift @line;
        if( $cnt =~ /(?:^|[^0-9A-Za-z_])${func}\(/m )
        {   foreach ( @line )
            {   print "#include <$_>\n";
            }
        }
    }
' < "$headers_db" \
| sort -u
################################################################################
