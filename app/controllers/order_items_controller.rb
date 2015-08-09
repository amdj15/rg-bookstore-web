class OrderItemsController < ApplicationController
  def add
    @book = Book.find(params[:item][:book_id])
    @current_order.add_book(@book, params[:item][:quantity])

    respond_to do |format|
      format.html { redirect_to request.referer, notice: t(:item_has_been_added_to_cart).capitalize }
      format.json { render json: @current_order }
    end
  end

  def destroy
  end
end
