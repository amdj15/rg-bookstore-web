class BooksController < ApplicationController
  before_action :admin_access, only: [:new, :edit, :create, :update, :destroy]

  before_action :set_category, except: [:all, :new, :create]
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :get_meta_data, only: [:new, :edit, :create]

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to [@book.category, @book], notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: [@book.category, @book] }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to [@book.category, @book], notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: [@book.category, @book] }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to category_books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def all
    @books = Book.all

    respond_to do |format|
      format.html { render :index }
    end
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

    def get_meta_data
      @categories = Category.all
      @authors = Author.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :price, :description, :books_in_stock, :category_id, :author_id)
    end
end
