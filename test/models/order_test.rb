require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "test_that_we_can_create_a_valid_order" do
    order = Order.new( 
            # Contact Information
            email: 'abcdef@gmail.com',
            phone_number: '3498438943843',
            # Shipping Address
            ship_to_first_name: 'Hallon',
            ship_to_last_name: 'Saft',
            ship_to_address: 'Street',
            ship_to_city: 'City',
            ship_to_postal_code: 'Code',
            ship_to_country: 'Iceland',
            )
    # Private parts
    order.customer_ip = '10.0.0.1'
    order.status = 'processed'
    # Billing Information
    order.card_type = 'Visa'
    order.card_number = '4007000000027'
    order.card_expiration_month = '1'
    order.card_expiration_year = '2030'
    order.card_verification_value = '333'

    order_item = OrderItem.new(
            book_id: 1,
            price: 100,
            amount: 13
          )   
    order.order_items << order_item
    assert order.save
    order.reload
     
    assert_equal 1, order.order_items.size
    assert_equal 100, order.order_items[0].price
  end

  test "test_that_validation_works" do
    order = Order.new
    assert_equal false, order.save
    # An order should have at least one order item
    #assert order.errors.on(:order_items)
    assert_equal(["is too short (minimum is 1 character)"], order.errors.messages[:order_items])
    assert_equal 16, order.errors.size
    # Contact Information
    #assert order.errors.on(:email).any?
    assert_equal(["is invalid"], order.errors.messages[:email])
    #assert order.errors.on(:phone_number).any?
    assert_equal(["is too short (minimum is 7 characters)"], order.errors.messages[:phone_number])
    assert_equal(["is too short (minimum is 2 characters)"], order.errors.messages[:ship_to_first_name])
    assert_equal(["is too short (minimum is 2 characters)"], order.errors.messages[:ship_to_last_name])
    assert_equal(["is too short (minimum is 2 characters)"], order.errors.messages[:ship_to_address])
    assert_equal(["is too short (minimum is 2 characters)"], order.errors.messages[:ship_to_city])
    assert_equal(["is too short (minimum is 2 characters)"], order.errors.messages[:ship_to_postal_code])
    assert_equal(["is too short (minimum is 2 characters)"], order.errors.messages[:ship_to_country])
    assert_equal(["is too short (minimum is 7 characters)"], order.errors.messages[:phone_number])
    assert_equal(["is too short (minimum is 7 characters)"], order.errors.messages[:customer_ip])
    assert_equal([" is not valid"], order.errors.messages[:status])
    assert_equal([" is not valid card type"], order.errors.messages[:card_type])
    assert_equal(["is too short (minimum is 13 characters)"], order.errors.messages[:card_number])
    assert_equal([" is not a valid month"], order.errors.messages[:card_expiration_month])
    assert_equal([" is not a valid year"], order.errors.messages[:card_expiration_year])
    assert_equal(["is too short (minimum is 3 characters)"], order.errors.messages[:card_verification_value])
    # Shipping Address
    #assert order.errors.on(:ship_to_first_name).any?
    #assert_equal("Ship to first name is too short (minimum is 2 characters)", order.errors.full_messages[2])
    #assert order.errors.on(:ship_to_last_name).any?
    #assert order.errors.on(:ship_to_address).any?
    #assert order.errors.on(:ship_to_city).any?
    #assert order.errors.on(:ship_to_postal_code).any?
    #assert order.errors.on(:ship_to_country).any?
    # Billing Information
    #assert order.errors.on(:card_type).any?
    #assert order.errors.on(:card_number).any?
    #assert order.errors.on(:card_expiration_month).any?
    #assert order.errors.on(:card_expiration_year).any?
    #assert order.errors.on(:card_verification_value).any?
    #assert order.errors.on(:customer_ip).any?
  end
end