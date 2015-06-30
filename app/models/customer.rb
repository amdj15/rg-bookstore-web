class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings, as: :item
  has_one :credit_card

  has_many :reviews, class_name: "Rating"

  validates :email, :password, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, on: :create
  validates :firstname, :lastname, presence: true, on: :update
  validates :email, uniqueness: true
  validates :admin, inclusion: [true, false]

  before_save :hash_pass

  @@salt = 'sdsd23kedio2jdo2ij3edmo2oi34'

  def self.authenticate(email, password)
    find_by_email_and_password(email, generate_hash(password))
  end

  def create_order
    Order.new customer: self
  end

  private
    def hash_pass
      if password_changed?
        self.password = self.class.generate_hash(password)
      end
    end

    def self.generate_hash(password)
      Digest::SHA2.hexdigest(Digest::SHA2.hexdigest(@@salt + password) + @@salt.reverse)
    end
end
