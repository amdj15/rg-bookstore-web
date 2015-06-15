class OrderItem < ActiveRecord::Base
  validates :price, :quantity, presecne: true

  belongs_to :order
  belongs_to :book
end
