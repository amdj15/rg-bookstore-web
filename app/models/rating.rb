class Rating < ActiveRecord::Base
  validates :rating, inclusion: { in: (1..10) }, presence: true

  belongs_to :customer
  belongs_to :item, polymorphic: true
end
