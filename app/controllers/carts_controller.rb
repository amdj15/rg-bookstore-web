class CartsController < ApplicationController
  def index
    @order = current_order
    @order_items = @order.order_items.includes(:book)
  end
end
