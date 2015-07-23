class SocialAccount < ActiveRecord::Base
  belongs_to :customer

  def self.take(provider, uid)
    where(social: provider, social_id: uid).first
  end
end
