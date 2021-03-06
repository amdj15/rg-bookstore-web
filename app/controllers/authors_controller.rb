class AuthorsController < ApplicationController
  before_action :set_author, only: [:show]
  authorize_resource

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.page params[:page]
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end
end
