class BooksController < ApplicationController
  before_action :set_category, except: [:all]

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
  end

  def all
    @books = Book.all.includes(:categories)
  end

  private
    def set_category
      @category = Category.find(params[:category_id])
    end
end
