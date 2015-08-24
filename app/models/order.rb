class Order < ActiveRecord::Base
  include AASM

  aasm.attribute_name :state

  aasm do
    state :progress, initial: true
    state :completed
    state :shipped

    event :complete do
      transitions from: :progress, to: :completed, guard: :can_complete_order?
    end
  end

  STEPS = [:address, :delivery, :payment, :confirm, :complete]

  DELIVERY_TYPES =  {
    ground: {
      title: "UPS Ground",
      price: "5"
    },
    two_day: {
      title: "UPS Two Day",
      price: "10"
    },
    one_day: {
      title: "UPS One Day",
      price: "15"
    },
  }

  belongs_to :customer
  belongs_to :credit_card
  belongs_to :billing_address, class_name: "Address"
  belongs_to :shipping_address, class_name: "Address"

  scope :progress, ->{ where(state: :progress) }
  scope :completed, ->{ where(state: :completed) }
  scope :shipped, ->{ where(state: :shipped) }

  has_many :order_items

  validates :state, presence: true
  validates :delivery_type, inclusion: {in: DELIVERY_TYPES.keys.map{|i| i.to_s}.concat([nil])}

  def add_book(book, quantity = 1)
    item = order_items.where(book: book).first

    if item
      item.quantity += quantity.to_i
      item.save
    else
      order_items << OrderItem.new(book: book, quantity: quantity, price: book.price)
    end

    calculate_total_price!
    p save
  end

  def can_complete_order?
    if billing_address.id.nil? || shipping_address.id.nil? || customer.firstname.nil? || customer.lastname.nil? || customer.credit_card.id.nil? || delivery_type.nil?
      false
    else
      true
    end
  end

  def choose_delivery(type)
    self.total_price -= DELIVERY_TYPES[delivery_type.to_sym][:price].to_f if delivery_type
    self.delivery_type = type

    calculate_total_price!
  end

  def items_price
    order_items.map{ |item| item.price * item.quantity }.inject(:+)
  end

  def calculate_total_price!
    price = items_price
    price += DELIVERY_TYPES[delivery_type.to_sym][:price].to_f if delivery_type

    self.total_price = price
  end

  def clear
    order_items.destroy_all

    self.delivery_type = nil
    self.total_price = 0

    save
  end
end