class ImapuserauthController < ApplicationController
  layout 'admin'

  before_action :require_admin

  def index
    @settings = Setting.plugin_imap_user_auth
  end

  def updateDatabase
    setting = params[:settings] ? params[:settings].permit!.to_h : {}
    Setting.send "plugin_imap_user_auth=", setting

    imap = AuthSource.where(type: 'AuthSourceIMAP').first_or_initialize
    imap.name = setting['name']
    imap.host = setting['host']
    imap.port = setting['port']
    imap.attr_mail = setting['suffix']
    imap.onthefly_register = setting['otfr'] ? true : false
    imap.tls = setting['ssl'] ? true : false
    imap.save

    flash[:notice] = l(:notice_successful_update)

  end
end
