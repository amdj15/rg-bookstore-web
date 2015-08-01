class RatingsController < ApplicationController
  def destroy
    @book = Book.find(params[:book_id])
    @category = Category.find(params[:category_id])
    @rating = Rating.find(params[:id])

    authorize! :destroy, @rating

    @rating.destroy

    respond_to do |format|
      format.html { redirect_to [@category, @book], notice: t(:destroy_review_msg).capitalize }
      format.json { head :no_content }
    end
  end
end
