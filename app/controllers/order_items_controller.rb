class OrderItemsController < ApplicationController
  def add
    @order = current_order
    @book = Book.find(item_params[:book_id])

    @order.add_book(@book, item_params[:quantity])

    session[:order_id] = @order.id

    respond_to do |format|
      format.html { redirect_to request.referer, notice: t(:item_has_been_added_to_cart).capitalize }
      format.json { render json: @order }
    end
  end

  def destroy
  end

  private
    def item_params
      params.require(:item).permit(:book_id, :quantity)
    end
end
