require 'features/features_spec_helper'

feature "Registration" do
  scenario "Success sign up" do
    email = Faker::Internet.email

    visit new_customer_path
    within('#new_customer') do
      fill_in 'customer_email', with: email
      fill_in 'customer_password', with: "supperpassword"
      fill_in 'customer_password_confirmation', with: "supperpassword"

      click_button('Create Customer')
    end

    expect(page).to have_content "Customer created"
  end
end