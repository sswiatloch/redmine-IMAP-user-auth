# REDMINE UWIERZYTELNIANIE IMAP

## Wprowadzenie
### Wstęp
Zarządzanie projektem informatycznym to nie lada wyzwanie. Przekroczony termin, budżet lub niekompletność dotyczyły w 2012 r. aż **43\%** projektów [[1]](http://athena.ecs.csus.edu/~buckley/CSc231_files/Standish_2013_Report.pdf). Z tego powodu niezwykle ważnym jest wybór odpowiednich narzędzi wspierajacych proces ich prowadzenia. Jednym z takich narzędzi jest **Redmine** - łatwo konfigurowalna i rozszerzalna aplikacja webowa do zarządzania projektami. Została napisana z wykorzystaniem frameworku **Ruby on Rails**, jest wieloplatformowa i obsługuje różne systemy zarządzania bazą danych.
### Cel i założenia projektu
Celem projektu jest dodanie możliwości uwierzytelniania w **Redmine** za pomocą serwera **IMAP**. Dzięki temu użytkownicy mający konto pocztowe, będą mogli wykorzystać swój istniejący login i hasło do zalogowania do **Redmine**. Utworzony zostanie również formularz umożliwiający konfigurację uwierzytelniania z poziomu panelu administratora.

## Opis funkcjonalności
1. Frontend (konfiguracja wtyczki w panelu administratora)
    - Pola tekstowe: **Host**, **Port** i **Suffix e-mail** gdzie konieczne jest podanie danych serwera IMAP
    - Pole tekstowe: **Nazwa metody uwierzytelniania** pozwalająca nazwać ten sposób uwierzytelniania (nazwa będzie wyświetlana w panelu administratora w zakładce każdego użytkownika)
    - Checkbox: **Rejestracja w locie** pozwalający na logowanie i rejestrację za pomocą loginu i hasła IMAP, bez konieczności wcześniejszej rejestracji w Redmine
    - Checkbox: **Używaj SSL** włączający lub wyłączający szyfrowanie przy łączeniu z serwerem poczty
    - Checkbox: **Bypass SSL** ustawia odpowienie opcje podczas zapytania do serwera IMAP, rozwiązując wystąpienie błędu `OpenSSL::SSL::SSLError (hostname does not match the server certificate)`
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


## Diagram UML
![Diagram](https://raw.githubusercontent.com/sswiatloch/redmine-IMAP-user-auth/main/doc/component_diagram.png)

## Opis instalacji
Kod udostępniony zostanie jako plugin i instalowany będzie w standardowy sposób, to znaczy przez przeniesienie folderu wtyczki do  **`redmine/plugins`**.

Następnie należy wykonać restart **Redmine**. W tym momencie wtyczka powinna pojawić się w panelu administatora. 

Następnie konieczne jest utworzenie konfiguracji odpowiedniego serwera **IMAP** w menu **Imap Authentication** w panelu Administratora.

Od teraz uwierzytelnianie **IMAP** jest dostępne.

## Opis użytkowania
Konfiguracja wtyczki jest dostępna w panelu administratora w menu **Imap Authentication**. Opis i znaczenie pól można znaleźć w [opisie funkcjonalności](https://github.com/sswiatloch/redmine-IMAP-user-auth/blob/main/doc/dokumentacja.md#Opis-funkcjonalności). Pole **Bypass SSL** zaleca sie, aby było odznaczone, chyba że wystąpi opisany wcześniej błąd. W celu zapisania zmian, należy nacisnąć przycisk **Apply**.

Aby zmienić sposób uwierzytelniania wybranego użytkwonika, należy przejść do menu **Users**, wybrać go z listy i zmienić wartość pola **Authentication mode** na nazwę wybraną podczas konfiguracji. Tak samo ustawia się metodę autentyfikacji podczas tworzenia nowego użytkownika. Ważne, aby login użytkownika był taki sam jak login na serwerze IMAP. Po tej zmianie użytkownik powinien używać swojego hasła do konta na serwerze IMAP.

Z perspektywy zwykłego użytkownika nie można uzyskać dostępu do widoku konfiguracji wtyczki, możliwość taką ma tylko administrator.

W przypadku ustawienia opcji rejestracji w locie, użytkownik niezarejstrowany w systemie Redmine, po udanej autentyfikacji z serwerem IMAP, zostanie poproszony o wypełnienie formularza tworzącego nowego użytkownika.

## Analiza ryzyk

- Niedotrzymanie terminu - w wyniku niedoszacowania złożoności problemu lub zdarzeń losowych mogą wystąpić opóźnienia. Aby nie przekroczyć terminu 16 czerwca 2021, termin oddania implementacji w [Planie prac](https://github.com/sswiatloch/redmine-IMAP-user-auth/blob/main/doc/plan_prac.md) został ustanowiony na 26 maja 2021, co daje 3 tygodniowy bufor na ewentualne opóźnienia. Prawdopodobieństwo: średnie; konsekwencje: poważne.
- Brak możliwości implementacji funkcjonalności - możliwe jest, że niektórych funkcjonalności nie można zaimplementować w systemie Redmine. Ryzyko to jest znikome, ponieważ analiza problemu i systemu wykazała, że poszczególne funkcjonalności już istnieją i działają w tym środowisku. Prawdopodbieństwo: niewielkie; konsekwencje: poważne.
- Słabe bezpieczeństwo - zapewnienie odpowiedniego poziomu bezpieczeństwa jest bardzo ważne, aby poprawnie przeprowadzać autentyfikacje użytkowników i zapobiec nieupoważnionemu dostępowi. Projekt modułu autentyfikacji jest na podstawie oficjalnego [HowTo](https://www.redmine.org/projects/redmine/wiki/Alternativecustom_authentication_HowTo), dlatego bezpieczeństwo powinno być zagwarantowane przez ogólną architekturę systemu. Inne kwestie bezpieczeństwa, jak zewnętrzna biblioteka Net::IMAP lub odpiednia konfiguracja, nie zależą od autorów projektu. Prawdopodobieństwo: niewielkie; konsekwencje: poważne.

## Wykorzystane narzędzia
- **GitHub** - repozytorium kodu oraz zarządzanie projektem (tablica kanban)
- **WEBrick server** - serwer HTTP do testowania rowiązania
- **hMailServer** - serwer IMAP do testowania autentyfikacji bez SSL
- **poczta interia.pl** - do testowania autentyfikacji z SSL
- **Overleaf** - tworzenie dokumentacji
