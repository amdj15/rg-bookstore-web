class Author < ActiveRecord::Base
  has_many :books
  has_many :ratings, as: :item
  validates :firstname, :lastname, presence: true
end
