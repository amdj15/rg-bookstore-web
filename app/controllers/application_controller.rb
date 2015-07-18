class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :current_user

  # helper_method :current_user
  # helper_method :is_admin?
  # helper_method :authenticated?

  # private
  #   def authenticated?
  #     @current_user != nil
  #   end

  #   def is_admin?
  #     @current_user && @current_user.admin
  #   end

  #   def current_user
  #     @current_user ||= Customer.find(session[:customer_id]) if session[:customer_id]
  #   end

  #   def admin_access
  #     raise ActionController::RoutingError.new('Not Found') unless is_admin?
  #   end

  #   def unlogged_access
  #     redirect_to root_path if authenticated?
  #   end
end
