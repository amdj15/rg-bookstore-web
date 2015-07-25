class Book < ActiveRecord::Base
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :categories

  has_many :order_items, dependent: :destroy
  has_many :ratings, dependent: :destroy, as: :item

  validates :title, :price, :books_in_stock, :authors, :categories, presence: true
  validates :books_in_stock, numericality: {greater_than_or_equal_to: 0}

  mount_uploader :picture, PictureUploader
end
