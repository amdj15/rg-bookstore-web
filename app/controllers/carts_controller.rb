class CartsController < ApplicationController
  def index
    @order = @current_order
    @order.order_items = @order.order_items.includes(book: :categories)
  end

  def add
    @book = Book.find(params[:item][:book_id])
    @current_order.add_book(@book, params[:item][:quantity].blank? ? 1 : params[:item][:quantity])

    respond_to do |format|
      format.html { redirect_to :back, notice: t(:item_has_been_added_to_cart).capitalize }
      format.json { render json: @current_order }
    end
  end

  def update
    @current_order.order_items.each do |order_item|
      if order_item.quantity.to_i != params[:items][order_item.id.to_s][:quantity].to_i
        order_item.quantity = params[:items][order_item.id.to_s][:quantity]
        order_item.save
      end
    end

    @current_order.calculate_total_price!
    @current_order.save

    redirect_to cart_index_path
  end

  def delete_item
    order_item = OrderItem.find(params[:item_id])

    if order_item.order == @current_order
      order_item.delete

      @current_order.calculate_total_price!
      @current_order.save
    end

    redirect_to :back
  end

  def clear
    @current_order.clear
    redirect_to :back
  end
end
