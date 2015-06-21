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

  validates :total_price, :completed_date, presence: true
  validates :state, presence: true, inclusion: { in: STATES.values }

  before_validation :defaults_values

  def add_book(book, quantity = 1)
    item = order_items.where(book: book).first

    if item
      item.quantity += quantity
      item.save
    else
      order_items << OrderItem.new(book: book, quantity: quantity, price: book.price)
      save
    end
  end

  def defaults_values
    self.state ||= STATES[:progress]
  end
end
