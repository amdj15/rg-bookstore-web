class CustomerMailer < ApplicationMailer
  def social_registration(customer, password)
    @customer = customer
    @password = password

    mail(to: @customer.email, subject: "Welcome!")
  end
end
