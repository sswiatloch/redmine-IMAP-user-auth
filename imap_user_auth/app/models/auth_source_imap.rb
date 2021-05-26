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

#
# HOWTO
#
# 1. Execute the SQL
#    INSERT INTO auth_sources (type, name) values ("AuthSourceIMAP", "IMAP")
# 2. Change as you like
# 3. Redmine: set the user authentication mode to IMAP
# 4. Restart your web server
#

class AuthSourceIMAP < AuthSource
    def onthefly_register
        true
    end
    
    def authenticate(login, password)
        puts "[DEBUG] 5.1"
        # Define your IMAP server
        self.host = "poczta.interia.pl"
        #self.host = "127.0.0.1" 
        # self.port = 143
        self.port = 993
        retVal = {
            :firstname => self.attr_firstname,
            :lastname => self.attr_lastname,
            :mail => self.attr_mail,
            :auth_source_id => self.id
        }
        # Email as account if you use Google Apps
        #suffix = "@mail.local";
        suffix = "@interia.pl"
        if not login.end_with?(suffix)
            login += suffix
        end
        # Authenticate
        options = {
                :port => self.port,
                :ssl => true
                #  {
                #   #add this to bypass OpenSSL::SSL::SSLError 
                #   #(hostname does not match the server certificate) error.
                #   :verify_mode => OpenSSL::SSL::VERIFY_NONE
                # }
        }
        begin
            puts "[DEBUG] 5.2"
            imap = Net::IMAP.new(self.host, options)
            #substituted imap.authenticate with imap.login
            imap.login(login, password)
        rescue Net::IMAP::NoResponseError => e
            puts "[DEBUG] 5.3"
            retVal = nil
        end

        
        puts "[DEBUG] 5.4"
        
        return retVal
    end

    def auth_method_name
        "IMAP" 
    end
end