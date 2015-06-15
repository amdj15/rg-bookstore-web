class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category

  validates :title, :price, :books_in_stock, presence: true
end
