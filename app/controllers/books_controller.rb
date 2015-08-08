class BooksController < ApplicationController
  before_action :set_meta_data, except: [:all]
  authorize_resource

  def all
    @books = Book.all.includes(:categories)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # def review
  #   @review = Rating.new
  # end

  # def create_review
  #   @book.ratings.build rating_params.merge(customer: current_customer)

  #   respond_to do |format|
  #     if @book.save
  #       format.html { redirect_to [@category, @book], notice: t(:review_created).capitalize }
  #       format.json { render :review, status: :created }
  #     else
  #       format.html { render :review }
  #       format.json { render json: @book.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private
    def set_meta_data
      @book = Book.find(params[:id])
      @category = Category.find(params[:category_id])
    end

    # def rating_params
    #   params.require(:rating).permit(:rating, :review)
    # end
end
