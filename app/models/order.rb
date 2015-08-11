class Order < ActiveRecord::Base
  include AASM

  aasm.attribute_name :state

  aasm do
    state :progress, initial: true
    state :completed
    state :shipped

    event :complete do
      transitions from: :progress, to: :completed
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
  validates :delivery_type, presence: true, allow_blank: false

  after_initialize :defaults

  def defaults
    self.delivery_type = :ground
  end

  def add_book(book, quantity = 1)
    item = order_items.where(book: book).first

    if item
      item.quantity += quantity.to_i
      item.save
    else
      order_items << OrderItem.new(book: book, quantity: quantity, price: book.price)
    end

    self.total_price = calculate_total_price
    save
  end

  private
    def calculate_total_price
      order_items.map{ |item| item.price * item.quantity }.inject(:+)
    end
end
