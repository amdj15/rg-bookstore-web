class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         :omniauth_providers => [:facebook]


  has_many :orders
  has_many :ratings, as: :item
  has_one :credit_card

  has_many :reviews, class_name: "Rating"
  has_many :social_accounts

  validates :email, presence: true
  validates :firstname, :lastname, presence: true, on: :update
  validates :email, uniqueness: true
  validates :admin, inclusion: [true, false]

  def create_order
    Order.new customer: self
  end

  def is_admin?
    admin
  end
end
