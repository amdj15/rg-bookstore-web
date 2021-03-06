class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  authorize_resource

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.page params[:page]
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @category, include: :books }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end
end
