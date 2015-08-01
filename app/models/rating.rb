class Rating < ActiveRecord::Base
  RATING_RANGE = 1..10

  validates :rating, inclusion: { in: RATING_RANGE }, presence: true
  validates :review, presence: true

  belongs_to :customer
  belongs_to :item, polymorphic: true
end
