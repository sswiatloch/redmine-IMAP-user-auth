##
# Redmine IMAP Authentication Module
#
# All rights avoided, you are free to distribute or modify
# the source code under the terms you reserve the author information.
#
# Author:
#     Dingding Technology, Inc.
#     Sunding Wei <swei(at)dingding.me>
#
# File: redmine/app/models/auth_source_imap.rb
#
require "net/imap" 
require 'timeout'

# Configuration values are assumed to be in database and are read as for example: self.host
# Alternative option is reading them from plugin settings for example: Setting.plugin_imap_user_auth['host']

# When logging with email username@address.com, user inputs: username

class AuthSourceIMAP < AuthSource
    def authenticate(login, password)

        suffix = self.attr_mail
        login += suffix

        retVal = {
            :firstname => self.attr_firstname,
            :lastname => self.attr_lastname,
            :mail => login,
            :auth_source_id => self.id
        }

        options = {
                :port => self.port,
                :ssl => self.tls ? (Setting.plugin_imap_user_auth['bypass'] ? {:verify_mode => OpenSSL::SSL::VERIFY_NONE} : true ) : false
        }
		
        begin
            imap = Net::IMAP.new(self.host, options)
            imap.login(login, password)
        rescue Net::IMAP::NoResponseError => e
            retVal = nil
        end
        
        return retVal
    end

    def auth_method_name
        "IMAP" 
    end
end