require "test_helper"

class CheckoutTest < ActionDispatch::IntegrationTest
  fixtures :authors, :publishers, :books

  def setup
    User.create(email: "george@emporium.com",
                password: "cheetah",
                password_confirmation: "cheetah")
  end

  test "test_that_empty_cart_shows_error_message" do
    get '/users/sign_in'
    post "/users/sign_in", params: { user: { email: 'george@emporium.com', password: "cheetah"} } 
    assert_equal "Signed in successfully.", flash[:notice]
    get '/checkout'
    assert_response :redirect  
    assert_redirected_to '/catalog/index'
    assert_equal "Your shopping cart is empty! Please add something to it before proceeding to checkout.", flash[:notice]
  end

  test "that_placing_an_order_works" do
    get '/users/sign_in'
    post "/users/sign_in", params: { user: { email: 'george@emporium.com', password: "cheetah"} } 
    assert_equal "Signed in successfully.", flash[:notice]
    get '/catalog/index'
    assert_response :success
    post '/cart/1'
    get '/checkout'
    assert_response :success
    assert_select 'fieldset'
    assert_select 'legend', "Contact Information"
    post "/checkout/", params: { order: { 
              # Contact Information
              email: 'abce@gmail.com',
              phone_number: '3498438943843',
              # Shipping Address
              ship_to_first_name: 'Hallon',
              ship_to_last_name: 'Saft',
              ship_to_address: 'Street',
              ship_to_city: 'City',
              ship_to_postal_code: 'Code',
              ship_to_country: 'AR',
              # Billing Information
              card_type: 'Visa',
              card_number: '4007000000027',
              card_expiration_month: '1',
              card_expiration_year: '2009',
              card_verification_value: '333',
              } }
    assert_response :redirect
    assert_redirected_to '/checkout/thank_you'

  end

  
end
