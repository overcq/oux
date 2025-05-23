# Architektury

* x86_64
* x86

# Systemy testowania

* Gentoo Linux

System operacyjny tworzenia oprogramowania.
![Gentoo](picture/Gentoo.png)

* FreeBSD 13.1

Uruchamia się.
![FreeBSD](picture/FreeBSD.png)

* NetBSD 10.1

Wymaga opcji budowania do pojedynczego pliku programu.
![NetBSD](picture/NetBSD.png)

* OpenBSD 7.1

Występuje błąd podczas uruchamiania.
![OpenBSD](picture/OpenBSD.png)

# Wymagania

W systemie kompilacji powinny być zainstalowane:
* programy narzędziowe
* clang lub gcc
* dokumentacja “man” funkcji systemowych i poniższych bibliotek
* OpenSSL
* xcb

Do uruchomienia programu testowego (“make run”) powinnien być zainstalowany:
* zmodyfikowany [urxvt](https://github.com/overcq/rxvt-unicode), ewentualnie xterm

# Kompilacja i instalacja

Poniżej jest odwołanie do programu GNU “make”, który może być urchamiany poleceniem “gmake”.

Należy wykonać:
1. jako zwykły użytkownik: “make” i potwierdzić zgodę na warunki użytkowania
2. jako użytkownik “root”: ”make install”

# Budowanie programów zależnych od tego środowiska

Katalog “oux” powinien znajdować się w którymkolwiek nadrzędnym katalogu względem katalogu programu zależnego od tego środowiska, z wyjątkiem katalogu ”/”.

Wtedy można w katalogu programu zależnego od tego środowiska wykonać “make”.
