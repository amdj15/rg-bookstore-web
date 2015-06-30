class CustomersController < ApplicationController
  before_action :unlogged_access, only: [:new, :create]

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to root_path, notice: "Customer created" }
        format.json { render json: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:email, :password, :password_confirmation, :firstname, :lastname)
    end
end
