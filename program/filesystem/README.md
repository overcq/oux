# System plików OUX/C+ wersja 1
## Specyfikacja

System plików składa się z
1. Volume Boot Record (VBR) w pierwszych 512 bajtach
2. przestrzeni danych plików
3. listy opisów plików na końcu partycji

Klaster w systemie plików ma rozmiar 4096 B.

Słowa w VBR i na liście opisów plików są zapisane w kolejności od najmniej znaczącego bajtu.

### Volume Boot Record

VBR ma rozmiar 512 B i może zawierać program startowy lub nie.
Bajt nr 439 zawiera numer *wersji systemu plików*.
Zależnie od wersji systemu plików poniżej znajdują się następujące pola opisu.

Bajt nr 438 zawiera *rozmiar adresu klastra* w tym systemie plików wyrażony jako numer kolejny ustawionego bitu (potęga dwójki).

Słowo nr 436, o rozmiarze 2 B, zawiera numer bajtu *początku tablicy opisów plików* w klastrze.

Słowo nr 436 minus rozmiar adresu klastra, o rozmiarze adresu klastra, zawiera numer klastra *początku tablicy opisów plików*.

<table>
<caption>Dane systemu plików w VBR</caption>
<thead>
    <tr><th>436 − rozmiar_adresu_klastra</th><th>436</th><th>438</th><th>439</th></tr>
</thead>
<tbody>
    <tr><td>początek tablicy opisów plików – numer klastra</td><td>początek tablicy opisów plików – numer bajtu w klastrze</td><td>rozmiar adresu klastra</td><td>wersja systemu plików</td></tr>
</tbody>
</table>

### Przestrzeń danych plików

W przestrzeni partycji ułożone są bloki zawartości plików. Blok jest ciągły (niesfragmentowany).

Blok może mieć rozmiar
1. mniejszy od rozmiaru klastra, a wtedy może rozpoczynać się nie od początku klastra
2. dowolny (mniejszy, równy lub większy od rozmiaru klastra) i rozpoczynać się od początku klastra

### Lista opisów plików

Lista opisów plików jest tablicą o zmiennej długości rekordów.
Ogólna postać rekordu jest następująca:

<table>
    <caption>Rekord</caption>
    <tr><td>numer rekordu nadrzędnego katalogu</td><td>rozmiar pliku w ostatnim klastrze zawartości i flagi</td><td>inne pola</td><td>nazwa pliku lub katalogu</td></tr>
</table>

1. Numer rekordu nadrzędnego katalogu ma rozmiar adresu klastra.
Jeśli brak nadrzędnego katalogu (plik lub katalog znajduje się w katalogu głównym), to wartość `FUSE_ROOT_ID` (1).
2. Rozmiar pliku w ostatnim klastrze zawartości i flagi ma rozmiar 16 bitów, a flagi zawierają się w `0xf000` słowa.
Są następujące flagi:
* `0x1000` oznaczająca, że wpis jest katalogiem
* `0x4000` oznaczająca wpis niezmienialny
* `0x8000` oznaczająca wpis pusty
3. Nazwa pliku lub katalogu jest tekstem UTF-8 zakończonym znakiem `\0`.

#### Inne pola w rekordzie katalogu

Brak pól.

#### Inne pola w rekordzie pliku

<table>
    <caption>Inne pola</caption>
    <tr><td>numer bajtu początku zawartości w pojedynczym klastrze i flagi</td><td>numer klastra początku zawartości pliku</td><td>liczba pełnych klastrów zawartości pliku</td></tr>
</table>

1. Numer bajtu początku zawartości w pojedynczym klastrze i flagi ma rozmiar 16 bitów, a flagi zawierają się w `0xf000` słowa.
Jeśli zawartość pliku nie jest mniejsza od rozmiaru klastra, to wartość tego pola powinna wynosić `0x000`.
Obecnie brak zdefiniowanych flag.
2. Numer klastra początku zawartości pliku ma rozmiar adresu klastra.
Jeśli plik jest pusty, to powinien wynosić 0.
3. Liczba pełnych klastrów zawartości pliku ma rozmiar adresu klastra.
