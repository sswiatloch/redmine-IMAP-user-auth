# Redmine IMAP user authentication plugin
Adds user authentication against IMAP server. Core functionality was imported from [User auth against an IMAP server - is it wanted?](https://www.redmine.org/boards/1/topics/9938) post on Redmine forum. This plugin adds configuration UI view in admin menu. The `doc` directory contains documentation in Polish, as this plugin was created as part of authors' university course. Instalation and usage information can be found bellow in this README. Plugin most likely won't be developed further, but you are free to modify and distribute it.

## Installation
- put `imap_user_auth` directory into `plugins` directory
- restart Redmine

## Usage
Configuration menu can be found in administration menu, under "IMAP authentication". Most boxes should be apparent. "Bypass SSL" checkbox should be used to solve `OpenSSL::SSL::SSLError (hostname does not match the server certificate)` error. Click "Apply" button to save changes.

## Authors
- [Andrzej Kołakowski](https://github.com/ondrikk)
- [Stanisław Światłoch](https://github.com/sswiatloch)
- [Sunding Wei](https://www.redmine.org/users/72848) and [Thanos Politis](https://www.redmine.org/users/88881) - authors of the original IMAP authentication module (`auth_sources_imap.rb`), found in the [forum post](https://www.redmine.org/boards/1/topics/9938) mentioned above

## Documentation in Polish
* [Dokumentacja](doc/dokumentacja.md)
* [Plan prac](doc/plan_prac.md)