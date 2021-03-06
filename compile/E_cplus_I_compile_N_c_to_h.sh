#!/bin/sh
################################################################################
#   ___   publicplace
#  ¦OUX¦  “sh”
#  ¦/C+¦  compile
#   ---   C+
#         “.cx” to “.h” utility for system headers
# ©overcq                on ‟Gentoo Linux 17.0” “x86_64”            2018‒11‒12 b
################################################################################
headers_db="$1"
cx_source="$2"
#===============================================================================
trap 'rm -f "$tmp_file"' EXIT
tmp_file="$( mktemp )"
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
> "$tmp_file"
grep -Fe / "$tmp_file"
grep -Fve / "$tmp_file"
true
################################################################################
