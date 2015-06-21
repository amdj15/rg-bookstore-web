class OrderItem < ActiveRecord::Base
  validates :price, :quantity, presence: true

  belongs_to :order
  belongs_to :book
end
