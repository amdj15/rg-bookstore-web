class AuthController < ApplicationController
  before_action :unlogged_access, except: :sign_out

  def sign_in
    @customer = Customer.new
  end

  def sign_out
    session[:customer_id] = nil
    redirect_to root_path
  end

  def authenticate
    @customer = Customer.authenticate(params[:email], params[:password])

    respond_to do |format|
      if @customer
        session[:customer_id] = @customer.id

        format.html { redirect_to root_path }
        format.json { render json: {notice: "Logged in", user: @customer} }
      else
        format.html { redirect_to auth_sign_in_path, notice: "Bad login or password" }
        format.json { render json: {error: "Bad login or password"}, status: :unprocessable_entity }
      end
    end
  end
end
