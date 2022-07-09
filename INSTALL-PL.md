# Wymagania

W systemie kompilacji powinny być zainstalowane:
* clang lub gcc
* dokumentacja “man” funkcji systemowych i poniższych bibliotek
* OpenSSL
* xcb

Do uruchomienia programu testowego (“make run”) powinnien być zainstalowany:
* zmodyfikowany [urxvt](https://github.com/overcq/rxvt-unicode), ewentualnie xterm

# Kompilacja i instalacja

Należy wykonać:
1. jako zwykły użytkownik: “make” i potwierdzić zgodę na warunki użytkowania
2. jako użytkownik “root”: ”make install”

# Budowanie programów zależnych od tego środowiska

Katalog “oux” powinien znajdować się w którymkolwiek nadrzędnym katalogu względem katalogu programu zależnego od tego środowiska, z wyjątkiem katalogu ”/”.
Wtedy można w katalogu programu zależnego od tego środowiska wykonać “make”.
