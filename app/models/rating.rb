class Rating < ActiveRecord::Base
  validates :rating, inclusion: { in: (1..10) }
  belongs_to :item, polymorphic: true
end
