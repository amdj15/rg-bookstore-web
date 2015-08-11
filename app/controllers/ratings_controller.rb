class RatingsController < ApplicationController
  before_filter :detect_owner
  before_filter :pathes, only: [:new, :create]

  load_and_authorize_resource only: [:new, :destroy]

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new rating_params.merge(customer: current_customer)

    authorize! :create, @rating

    @owner.ratings << @rating

    respond_to do |format|
      if @owner.save
        format.html { redirect_to :back, notice: t(:review_created).capitalize }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: t(:destroy_review_msg).capitalize }
      format.json { head :no_content }
    end
  end

  private
    def detect_owner
      klass = [Book, Author].detect{|item| params["#{item.name.underscore}_id"]}
      @owner = klass.find(params["#{klass.name.underscore}_id"])
    end

    def pathes
      @new_rating_path = Proc.new do
        prefix = request.path_parameters.map { |i| i[0].to_s.gsub(/_id$/, '') }.join("_").gsub(/^controller_action_/, '')

        send "#{prefix}_ratings_path"
      end
    end

    def rating_params
      params.require(:rating).permit(:rating, :review)
    end
end
