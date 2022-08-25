require "test_helper"

class AuthenticationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    User.create(email: "george@emporium.com",
                password: "cheetah",
                password_confirmation: "cheetah")
  end
  
  test "sign up" do
    
  end

  test "ask to login" do
    get "/books/new"
    assert_response :redirect
    assert_redirected_to "/users/sign_in"
  end

  test "login" do
    #sign_in :george
    post "/users/sign_in", params: { user: { email: 'george@emporium.com', password: "cheetah"} }   
    assert_response :redirect
    #sign_out :george
  end

  test "failing_login" do
    post "/users/sign_in", params: { user: { email: 'george@emporium.com', password: "cheetah1"} } 
    assert_redirected_to "/users/sign_in"
  end
  
=begin  def test_successful_login
    george = enter_site(:george)
    george.tries_to_go_to_admin
  end

  private
  module BrowsingTestDSL
    include ERB::Util
    attr_writer :name

    def tries_to_go_to_admin
      get "/admin/book/new"
      assert_response :redirect
      assert_redirected_to "/account/login"
    end
  end
  
  def enter_site(name)
    open_session do |session|
      session.extend(BrowsingTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
=end
end
