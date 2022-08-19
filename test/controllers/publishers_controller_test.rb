require "test_helper"

class PublishersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @publisher = publishers(:apress)
  end

  test "should get index" do
    get publishers_url
    assert_response :success
  end

  test "should get new" do
    get new_publisher_url
    assert_response :success
  end

  test "should create publisher" do
    #assert_difference('Publisher.count') do
    #  post publishers_url, params: { publisher: { publisher: @publisher.publisher } }
    #end
    num_publishers = Publisher.count
    post publishers_url, params: { publisher: { publisher: 'The Monopoly Publishing Company' } }
    assert_response :redirect
    #assert_redirected_to :action => 'list'
    assert_equal num_publishers +1, Publisher.count

    #assert_redirected_to publisher_url(Publisher.last)
  end

  test "should show publisher" do
    get publisher_url(@publisher)
    assert_response :success
    assert_template 'show'
  end

  test "should get edit" do
    get edit_publisher_url(@publisher)
    assert_response :success
  end

  test "should update publisher" do
    patch publisher_url(@publisher), params: { publisher: { publisher: @publisher.publisher } }
    assert_redirected_to publisher_url(@publisher)
  end

  test "should destroy publisher" do
    assert_difference('Publisher.count', -1) do
      delete publisher_url(@publisher)
    end

    assert_redirected_to publishers_url
  end
end
