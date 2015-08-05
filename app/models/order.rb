class Order < ActiveRecord::Base
  STATES = {
    progress: 'in progress',
    completed: 'completed',
    shipped: 'shipped'
  }

  belongs_to :customer
  belongs_to :credit_card
  belongs_to :billing_address, class_name: "Address"
  belongs_to :shipping_address, class_name: "Address"

  scope :progress, ->{ where(state: STATES[:progress]) }

  has_many :order_items

  # validates :total_price, :completed_date, presence: true
  validates :state, presence: true, inclusion: { in: STATES.values }

  before_validation :defaults_values

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

  def defaults_values
    self.state ||= STATES[:progress]
  end

  private
    def calculate_total_price
      order_items.map{ |item| item.price * item.quantity }.inject(:+)
    end
end
