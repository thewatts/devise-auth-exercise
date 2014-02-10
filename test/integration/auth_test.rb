require 'test_helper'

class ProperAccessTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = Storedom::Application
    @user = User.create!(
      name: "Joe Smith",
      email: "example@devise.com",
      password: "wootwoot",
      password_confirmation: "wootwoot"
    )
    @admin = User.create!(
      name: "Jim Bob",
      email: "admin@devise.com",
      password: "wootwoot",
      password_confirmation: "wootwoot",
      admin: true
    )
  end

  def test_it_can_log_in
    visit '/'

    within('nav') do
      click_on('Login')
    end

    fill_in "Email", with: @user.email
    fill_in "Password", with: "wootwoot"
    click_on "Sign in"

    assert page.has_content?("Signed in successfully."),
      "page should have welcome message when signed in."
  end

  def test_non_admin_orders
    log_in_user
    Order.create!(user_id: @user.id,
                  amount: 40
                  )

    Order.create!(user_id: @admin.id,
                  amount: 55)

    visit orders_path

    assert page.has_content?("1 Order"), "page should have correct order number"
  end

  def log_in_user
    visit '/'

    within('nav') do
      click_on('Login')
    end

    fill_in "Email", with: @user.email
    fill_in "Password", with: "wootwoot"
    click_on "Sign in"
  end
end
