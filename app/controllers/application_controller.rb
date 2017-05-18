class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :admin?, :page_title

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin?
    current_user.is_admin?
  end

  def page_title
  		I18n.t("#{controller_name}.#{action_name}", :default => current_user.name)
  end
end
