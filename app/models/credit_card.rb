class CreditCard < ActiveRecord::Base
  has_many :orders
  belongs_to :customer

  validates :number, :CVV, :month, :year, :firstname, :lastname, presence: true
  validates :number, format: {with:/\d{16}/}
  validates :CVV, format: {with: /\d{3}/}
  validates :month, format: {with: /0[1-9]|1[012]/}
  validates :year, numericality: {only_integer: true}
  validates :year, numericality: {greater_than_or_equal_to: Time.new.year}, on: :create
end
