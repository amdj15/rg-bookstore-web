class Author < ActiveRecord::Base
  has_and_belongs_to_many :books
  has_many :ratings, as: :item
  validates :firstname, :lastname, presence: true
end
