Redmine::Plugin.register :imap_user_auth do
  name 'Imap User Authentication plugin'
  author 'Andrzej Kołakowski, Stanisław Światłoch'
  description 'This is a plugin for Redmine allowing to use IMAP server as authentication method'
  version '0.0.1'
  url 'https://github.com/sswiatloch/redmine-IMAP-user-auth'
  author_url 'https://github.com/sswiatloch/redmine-IMAP-user-auth'
  settings default: {'host' => 'localhost', 'port' => 143, 'suffix' => '@mail.com', 'name' => 'IMAP', 'otfr' => true, 'ssl' => false, 'bypass' => false}, partial: 'settings/imap_settings'
end
