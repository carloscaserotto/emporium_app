require "test_helper"

class CartControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def test_adding
    assert_difference('CartItem.count') do
      post "/cart/3"
    end
    assert_response :redirect
    assert_redirected_to :controller => "catalog"
    assert_equal 1, Cart.find(@request.session[:cart_id]).cart_items.size
  end

  def test_adding_with_xhr
    assert_difference('CartItem.count') do
      #xhr :post, :add, :id => 5
      post "/cart/5", xhr: true
    end
    assert_response :success #get a normal 200 HTTP Success response.
    assert_equal 1, Cart.find(@request.session[:cart_id]).cart_items.size
  end
  def test_removing
    #post "/cart/3"
    #assert_equal [Book.find(3)], Cart.find(@request.session[:cart_id]).books
    #post :remove, :id => 4
    #get '/cart/dell/3', xhr: true
    #assert_equal [], Cart.find(@request.session[:cart_id]).books
  end
  def test_removing_with_xhr
  #    post :add, :id => 4
      assert_difference('CartItem.count') do
        post "/cart/4", xhr: true      
      end
      assert_equal 1, Cart.find(@request.session[:cart_id]).cart_items.first.amount
      assert_response :success #get a normal 200 HTTP Success response.
      assert_equal [Book.find(4)], Cart.find(@request.session[:cart_id]).books
      get '/cart/dell/4', xhr: true
      assert_response :success #get a normal 200 HTTP Success response.
      assert_equal 0, Cart.find(@request.session[:cart_id]).cart_items.first.amount
  end
  def test_clearing
  #  post :add, :id => 4
  #  assert_equal [Book.find(4)], Cart.find(@request.session[:cart_id]).books
  #  post :clear
  #  assert_response :redirect
  #  assert_redirected_to :controller => "catalog"
  #  assert_equal [], Cart.find(@request.session[:cart_id]).books
  end
  def test_clearing_with_xhr
    post "/cart/4", xhr: true      
    assert_equal [Book.find(4)], Cart.find(@request.session[:cart_id]).books
    get "/cart/clear", xhr: true      
    assert_response :success
    assert_equal 0, Cart.find(@request.session[:cart_id]).cart_items.size
  end
end
