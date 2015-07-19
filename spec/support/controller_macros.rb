module ControllerMacros
  def login_customer
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:customer]
      sign_in FactoryGirl.create(:customer) # Using factory girl as an example
    end
  end
end