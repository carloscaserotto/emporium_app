require "test_helper"

class CatalogControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:libro1)
  end
  test "should get index" do
    get catalog_index_url
    assert_response :success
  end

  test "should get show" do
    #get "/catalog/show/'#{@book.id}'"
    #get catalog_url(@book)
    #assert_response :success
  end

  test "should get search" do
    get catalog_search_url
    assert_response :success
  end

  test "should get latest" do
    get catalog_latest_url
    assert_response :success
  end
end
