# REDMINE UWIERZYTELNIANIE IMAP

## Wprowadzenie
### Wstęp
Zarządzanie projektem informatycznym to nie lada wyzwanie. Przekroczony termin, budżet lub niekompletność dotyczyły w 2012 r. aż **43\%** projektów [[1]](http://athena.ecs.csus.edu/~buckley/CSc231_files/Standish_2013_Report.pdf). Z tego powodu niezwykle ważnym jest wybór odpowiednich narzędzi wspierajacych proces ich prowadzenia. Jednym z takich narzędzi jest **Redmine** - łatwo konfigurowalna i rozszerzalna aplikacja webowa do zarządzania projektami. Została napisana z wykorzystaniem frameworku **Ruby on Rails**, jest wieloplatformowa i obsługuje różne systemy zarządzania bazą danych.
### Cel i założenia projektu
Celem projektu jest dodanie możliwości uwierzytelniania w **Redmine** za pomocą serwera **IMAP**. Dzięki temu użytkownicy mający konto pocztowe, będą mogli wykorzystać swój istniejący login i hasło do zalogowania do **Redmine**. Utworzony zostanie również formularz umożliwiający konfigurację uwierzytelniania z poziomu panelu administratora.

## Opis funkcjonalności
1. Frontend (konfiguracja wtyczki w panelu administratora)
    - Checkbox: **SSL** włączający lub wyłączający szyfrowanie przy łączeniu z serwerem poczty
    - Checkbox: **Rejestracja w locie** pozwalający na logowanie i rejestrację za pomocą loginu i hasła IMAP, bez konieczności wcześniejszej rejestracji w Redmine
    - Pola tekstowe: **Host** i **Port** gdzie konieczne jest podanie danych serwera IMAP
    - Pole tekstowe: **Nazwa metody uwierzytelniania** pozwalająca nazwać ten sposób uwierzytelniania (nazwa będzie wyświetlana w panelu administratora w zakładce każdego użytkownika)
    - Przycisk wywołujący zapytanie dodające uwierzytelnianie przez IMAP ustawione zgodnie z konfiguracją do bazy danych
    
2. Backend
    - Uwierzytelnienie na serwerze IMAP zgodnie z ustawioną konfiguracją

## Wymagania
### Przypadki użycia
1. Logowanie
    - Aktorzy: użytkownik
    - Warunki końcowe: użytkownik zostaje zalogowany i przekierowany do strony głównej
    - Warunki końcowe w przypadku niepowodzenia: użytkownik nie zostaje zalogowany i system wyświetla komunikat o nieudanym logowaniu
    - Scenariusz główny
      1. Użytkownik wybiera opcję logowania
      2. System wyświetla miejsce do wpisania loginu i hasła
      3. Użytkownik wpisuje login i hasło
      4. System wybiera sposób uwierzytelniania użytkownika w oparciu o wewnętrzną tabelę **`users`**
      5. System weryfikuje wpisane dane
      6. Użytkownik zostaje zalogowany i system przekierowuje użytkownika do strony głównej

    - Scenariusz alternatywny 1
      - f<sub>a1</sub>. Nowy użytkownik jest nieznany dla Redmine ale znany dla serwera IMAP, ustawiono rejestrację w locie, wtedy system wyświetla okno  rejstracji, gdzie użytkownik może uzupełnić swoje dane.
      - f<sub>a2</sub> Użytkownik uzupełnia swoje dane - Imię i Nazwisko.
      - f<sub>a3</sub> Powrót do kroku f.
    - Scenariusz alternatywny 2
      - f<sub>b1</sub>. Nowy użytkownik jest nieznany dla Redmine ale znany dla serwera IMAP, nie ustawiono rejestracji w locie
      - f<sub>b2</sub>. System wyświetla komunikat o nieudanym logowaniu i przechodzi do kroku b.
    - Scenariusz alternatywny 3
      - f<sub>c1</sub>.  Zarejestrowany użytkownik podał błędne dane, wtedy system wyświetla komunikat o nieudanym logowaniu i przechodzi do kroku b.

### Wymagania niefunkcjonalne
- Poprawne działanie na wersji **Redmine 4.2**
- Poprawne działanie na wersji **Ruby 2.7.3**
- Poprawne działanie na wersji **PostgreSQL &geq; 9.2**
- Interfejs w panelu administratora w języku angielskim
- Możliwość rozbudowy interfejsu o dodatkowe tłumaczenia
- Poprawne funkcjonowanie z usługą: **poczta.interia.pl** (SSL)
- Poprawne funkcjonowanie z **hMailServer** (No-SSL)
- Nieprzekraczalny termin dostarczenia aplikacji: **16 czerwca 2021**
## Diagramy UML

## Opis instalacji
Kod udostępniony zostanie jako plugin i instalowany będzie w standardowy sposób, to znaczy przez przeniesienie folderu wtyczki do  **`redmine/plugins`**.

Następnie należy wykonać restart **Redmine**. W tym momencie wtyczka powinna pojawić się w panelu administatora. 

Następnie konieczne jest utworzenie wpisu w tabeli **`auth_sources`** bazy danych. Należy to zrobić za pomocą przycisku w formularzu konfiguracji wtyczki w panelu administratora. Należy także zmienić domyślną konfigurację na odpowiadającą żądanemu serwerowi **IMAP**.

Ponowny restart **Redmine**.

Od teraz sposób uwierzytelniania każdego użytkownika może zostać zmieniony na **IMAP**.


## Analiza ryzyk

## Wykorzystane narzędzia
