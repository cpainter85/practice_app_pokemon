class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :ensure_authenticated_user

  def ensure_authenticated_user
    if !current_user
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
