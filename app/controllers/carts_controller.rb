class CartsController < ApplicationController
  def index
    @order_items = @current_order.order_items.includes(:book)
  end
end
