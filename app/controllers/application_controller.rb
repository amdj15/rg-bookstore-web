class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :current_order

  def current_ability
    @current_ability ||= Ability.new(current_customer)
  end

  def current_order?
    !session[:order_id].nil? && Order.progress.exists?(id: session[:order_id])
  end

  private
    def current_order
      @current_order = unless current_order?
        Order.new
      else
        Order.find(session[:order_id])
      end

      @current_order.customer = current_customer
      @current_order.save

      session[:order_id] = @current_order.id
    end
end
