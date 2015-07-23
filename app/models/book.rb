class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category

  has_many :order_items, dependent: :destroy
  has_many :ratings, dependent: :destroy, as: :item

  validates :title, :price, :books_in_stock, :author, :category, presence: true
  validates :books_in_stock, numericality: {greater_than_or_equal_to: 0}

  mount_uploader :picture, PictureUploader
end
