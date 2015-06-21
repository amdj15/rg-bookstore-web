class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category

  has_many :order_items, dependent: :destroy

  validates :title, :price, :books_in_stock, presence: true
end
