class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings, as: :item
  has_one :credit_card

  validates :email, :password, :firstname, :lastname, presence: true

  before_save :hash_pass

  @@salt = 'sdsd23kedio2jdo2ij3edmo2oi34'

  private
    def hash_pass
      if password_changed?
        self.password = generate_hash(password)
      end
    end

    def password_changed?
      return true if (self.id == nil)
      return Customer.find(self.id).password != password
    end

    def generate_hash(password)
      Digest::SHA2.hexdigest(Digest::SHA2.hexdigest(@@salt + password) + @@salt.reverse)
    end
end
