class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_ability
    @current_ability ||= Ability.new(current_customer)
  end

  def current_order
    unless current_order?
      Order.new
    else
      Order.find(session[:order_id])
    end
  end

  def current_order?
    !session[:order_id].nil? && Order.progress.exists?(id: session[:order_id])
  end
end
