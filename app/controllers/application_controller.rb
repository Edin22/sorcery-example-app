class ApplicationController < ActionController::Base
  protect_from_forgery
  
  activate_sorcery! do |config|
    #config.user_class = User
    config.authentications_class = UserProvider
    config.session_timeout = 10.minutes
    config.session_timeout_from_last_action = false
    
    config.controller_to_realm_map = {"application" => "Application", "users" => "Users"}
    
    config.oauth_providers = [:twitter, :facebook]
    
    config.twitter.key = "eYVNBjBDi33aa9GkA3w"
    config.twitter.secret = "XpbeSdCoaKSmQGSeokz5qcUATClRW5u08QWNfv71N8"
    config.twitter.callback_url = "http://0.0.0.0:3000/oauth/twitter_callback"
    
    config.facebook.key = "34cebc81c08a521bc66e212f947d73ec"
    config.facebook.secret = "5b458d179f61d4f036ee66a497ffbcd0"
    config.facebook.callback_url = "http://0.0.0.0:3000/oauth/facebook_callback"
  end
  
  before_filter :require_login, :except => [:not_authenticated]
  
  helper_method :current_users_list
  
  protected
  
  def not_authenticated
    redirect_to root_path, :alert => "Please login first."
  end
  
  def current_users_list
    current_users.map {|u| u.email}.join(", ")
  end

end
