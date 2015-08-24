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
    redirect_to cart_index_path if @current_order.order_items.length < 1
  end

  def next_step
    case params[:step].to_sym
    when Order::STEPS[0]
      @current_order.billing_address.update_attributes(address_params)
      @current_order.customer.update_attributes(customer_params)

      if params[:use_billing_address]
        @current_order.shipping_address.update_attributes(address_params)
      else
        @current_order.shipping_address.update_attributes(address_params(:shipping_address))
        @errors.concat(@current_order.shipping_address.errors.full_messages)
      end

      @errors.concat(@current_order.billing_address.errors.full_messages).concat(@current_order.customer.errors.full_messages)
    when Order::STEPS[1]
      @current_order.choose_delivery params[:delivery_type]

      @errors << t(:choose_delivery_type).capitalize unless params[:delivery_type]
    when Order::STEPS[2]
      @credit_card.update_attributes(credit_card_params)

      if @credit_card.valid?
        @current_order.customer.credit_card = @credit_card
      else
        @errors = @credit_card.errors.full_messages
      end
    when Order::STEPS[3]
      begin
        @current_order.complete!
        flash[:completed_order_id] = @current_order.id
      rescue AASM::InvalidTransition => e
        @errors << t(:cannot_change_state).capitalize
      end
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

    def address_params(type = :address)
      params.require(type).permit(:address, :zip, :country_id, :phone, :city)
    end

    def credit_card_params
      credit_card = params.require(:card).permit(:firstname, :lastname, :CVV, :number, :month, :year)
      credit_card[:number].gsub!(/\s+/, '')

      credit_card
    end
end