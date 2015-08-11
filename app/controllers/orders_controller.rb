class OrdersController < ApplicationController
  before_filter :authenticate_customer!
  before_filter :set_meta_data, only: [:checkout, :next_step]

  def index
    @orders = Order.accessible_by(current_ability)
  end

  def show
    @order = Order.accessible_by(current_ability).find(params[:id])
  end

  def checkout
  end

  def next_step
    case params[:step].to_sym
    when Order::STEPS[0]
      @current_order.billing_address.update_attributes(address_params)
      @current_order.customer.update_attributes(customer_params)

      @errors = @current_order.billing_address.errors.full_messages.concat(@current_order.customer.errors.full_messages)
    when Order::STEPS[1]
      @current_order.update_attributes(delivery_type: params[:delivery_type])

      @errors = @current_order.errors
    when Order::STEPS[2]
      @credit_card.update_attributes(credit_card_params)

      if @credit_card.valid?
        @current_order.customer.credit_card = @credit_card
      else
        @errors = @credit_card.errors.full_messages
      end
    when Order::STEPS[3]
      @current_order.complete!
      flash[:completed_order_id] = @current_order.id
    end

    if @errors.any?
      render :checkout
    else
      @current_order.save
      redirect_to checkout_orders_path(find_next_step)
    end
  end

  private
    def set_meta_data
      if flash[:completed_order_id]
        @current_order = Order.find(flash[:completed_order_id])
      end

      @current_order.billing_address ||= Address.new
      @current_order.shipping_address ||= Address.new

      @countries = Country.all
      @step = params[:step]
      @credit_card = current_customer && current_customer.credit_card || CreditCard.new

      @errors = []
    end

    def find_next_step
      current_step = Order::STEPS.index(params[:step].to_sym)

      if !current_step || Order::STEPS[current_step + 1].nil?
        params[:step]
      else
        Order::STEPS[current_step + 1]
      end
    end

    def customer_params
      params.require(:customer).permit(:firstname, :lastname)
    end

    def address_params
      params.require(:address).permit(:address, :zip, :country_id, :phone, :city)
    end

    def credit_card_params
      params.require(:card).permit(:firstname, :lastname, :CVV, :number, :month, :year)
    end
end
