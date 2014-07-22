class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :require_login, :except => [:index, :signin ,:signup, :login]

  private
  def require_login
    unless session[:user]
      redirect_to(:controller=>'user', :action=>'signin')
    end
  end
end
