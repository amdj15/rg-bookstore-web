class BooksController < ApplicationController
  before_action :set_category, except: [:all]
  before_action :set_book, only: [:show]

  # GET /books/1
  # GET /books/1.json
  def show
  end

  def all
    @books = Book.all.includes(:category)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])

      redirect_to [@book.category, @book] if @book.category != @category
    end

    def set_category
      @category = Category.find(params[:category_id])
    end
end
