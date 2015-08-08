class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    social_account = SocialAccount.take request.env["omniauth.auth"][:provider], request.env["omniauth.auth"][:uid]

    customer = if social_account
      social_account.customer
    else
      generated_password = Devise.friendly_token.first(8)

      customer = Customer.create!(
        :email => request.env["omniauth.auth"][:info][:email],
        :password => generated_password,
        :firstname => request.env["omniauth.auth"][:info][:first_name],
        :lastname => request.env["omniauth.auth"][:info][:last_name]
      )

      CustomerMailer.social_registration(customer, generated_password).deliver_later

      SocialAccount.create!(
        :customer => customer,
        :social => request.env["omniauth.auth"][:provider],
        :social_id => request.env["omniauth.auth"][:uid]
      )

      customer
    end

    sign_in_and_redirect customer
  end
end
