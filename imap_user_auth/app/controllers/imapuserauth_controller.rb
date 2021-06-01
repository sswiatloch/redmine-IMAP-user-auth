class ImapuserauthController < ApplicationController

  def index
    @settings = Setting.plugin_imap_user_auth
  end

  # TODO
  def updateDatabase
    AuthSourceIMAP.create(name: Setting.plugin_imap_user_auth['name'], onthefly_register: Setting.plugin_imap_user_auth['otfr'])
  end
end
