#!/bin/sh
################################################################################
#   ___   publicplace
#  ¦OUX¦  “sh”
#  ¦/C+¦  compile
#   ---   C+
#         generator bazy danych plików nagłówkowych ‟C”
# ©overcq                on ‟Gentoo Linux 17.0” “x86_64”            2018‒11‒12 Q
################################################################################
LANG=C
#===============================================================================
exc_man_re=''
exc_func_re='for|ioctl|main|sizeof|syscall|while'
#===============================================================================
for a in s
do
    apropos "$a"
done \
| awk '
    /^[A-Za-z_][0-9A-Za-z_]*( *, *[A-Za-z_][0-9A-Za-z_]*)*?( \[[0-9A-Za-z_-]+\])? *\([23]([A-Za-z][0-9A-Za-z]*)?(\/[0-9A-Za-z]*)?( *, *[23]([A-Za-z][0-9A-Za-z]*)?(\/[0-9A-Za-z]*)?)*?\)/ {
        if( match( $0, "^jemalloc *\\(3\\)" ) != 0 )
            next
        if( match( $0, "^[A-Za-z_][0-9A-Za-z_]*( *, *[A-Za-z_][0-9A-Za-z_]*)*? *, *PCRE2?\\([23]([A-Za-z][0-9A-Za-z]*)?(/[0-9A-Za-z]*)?( *, *[23]([A-Za-z][0-9A-Za-z]*)?(/[0-9A-Za-z]*)?)*?\\)" ) != 0 )
            next
        match( $0, "\\([23]([A-Za-z][0-9A-Za-z]*)?(/[0-9A-Za-z]*)?( *, *[23]([A-Za-z][0-9A-Za-z]*)?(/[0-9A-Za-z]*)?)*?\\)" )
        sects = substr( $0, RSTART, RLENGTH )
        match( sects, "^\\([23]([A-Za-z][0-9A-Za-z]*)?" )
        sect = substr( sects, RSTART + 1, 1 )
        match( $0, "^[A-Za-z_][0-9A-Za-z_]*( *, *[A-Za-z_][0-9A-Za-z_]*)*?" )
        split( substr( $0, RSTART, RLENGTH ), a, " *, *" )
        for ( i in a )
            if( a[i] != "pcreposix" )
                print sect, a[i]
    }
' \
#| sort -u \
| grep -Eve " (${exc_man_re})\$" \
| xargs -n 2 $SHELL -c 'echo "man $@" >&2; env MANPAGER=/bin/cat PAGER=/bin/cat man "$@"' $SHELL \
| awk '
    {
        gsub( "\033\\[[0-9]+m", "" )
        gsub( "[^\010]\010", "" )
        gsub( "\010", "" )
    }
    /[^ ]/
' \
| awk '
    /^SYNOPSIS$/,/^DESCRIPTION$/ {
        if( match( $0, "^SYNOPSIS$" ) != 0 )
        {   skip = 0
            headers = ""
        }else if( skip != 0 || match( $0, "^[A-Z]+$" ) != 0 )
            skip = 1
        else if( match( $0, "#include +<[^>]+>" ) != 0 || match( $0, "#include +\"[^\"]+\"" ) != 0 )
        {   match( $0, "<[^>]+>" ) || match( $0, "\"[^\"]+\"" )
            headers = headers " " substr( $0, RSTART + 1, RLENGTH - 2 )
        }else if( headers != "" && match( $0, "[A-Za-z_][0-9A-Za-z_]*\\(" ) != 0 )
        {   s = substr( $0, RSTART, RLENGTH - 1 )
            if( match( s, "^('"$exc_func_re"')$" ) == 0 )
                print s headers
        }
    }
' \
| sort \
| awk '
    {
        if( $1 != f )
        {   print $0
            f = $1
        }
    }
'
################################################################################
