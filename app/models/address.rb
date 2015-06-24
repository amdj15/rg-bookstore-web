class Address < ActiveRecord::Base
  validates :address, :zip, :city, :phone, presence: true

  belongs_to :country
end
