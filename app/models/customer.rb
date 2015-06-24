class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings, as: :item
  has_one :credit_card

  has_many :reviews, class_name: "Rating"

  validates :email, :password, :firstname, :lastname, presence: true
  validates :email, uniqueness: true

  before_save :hash_pass

  @@salt = 'sdsd23kedio2jdo2ij3edmo2oi34'

  def create_order
    Order.new customer: self
  end

  private
    def hash_pass
      if password_changed?
        self.password = generate_hash(password)
      end
    end

    def generate_hash(password)
      Digest::SHA2.hexdigest(Digest::SHA2.hexdigest(@@salt + password) + @@salt.reverse)
    end
end
