<?php

$_SERVER['SCRIPT_FILENAME'] = $_SERVER['argv'][1];

parse_str( $_SERVER['argv'][2], $_GET );

$_SERVER['SCRIPT_NAME'] = $_SERVER['PHP_SELF'] = $_SERVER['argv'][3];

$_SERVER['DOCUMENT_ROOT'] = $_SERVER['argv'][4];

if( isset( $_SERVER['argv'][5] ))
    parse_str( $_SERVER['argv'][5], $_POST );

$_s = $_SERVER['HTTP_COOKIE'];
str_replace( '; ', '&', $_s );
parse_str( $_s, $_COOKIE );

include $_SERVER['argv'][1];

print_r( $_COOKIE );
