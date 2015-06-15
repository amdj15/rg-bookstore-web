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

  has_many :order_items

  validates :total_price, :completed_date, presence: true
  validates :state, presence: true, inclusion: { in: STATES.values }

  before_validation :defaults_values

  def defaults_values
    self.state ||= STATES[:progress]
  end
end
