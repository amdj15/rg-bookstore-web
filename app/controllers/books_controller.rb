class BooksController < ApplicationController
  before_action :set_meta_data, except: [:all]
  authorize_resource

  def all
    @books = Book.includes(:categories).page params[:page]
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  private
    def set_meta_data
      @book = Book.find(params[:id])
      @category = Category.find(params[:category_id])
    end
end
