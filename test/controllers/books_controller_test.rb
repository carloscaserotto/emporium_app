require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:libro1)
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should get new" do
    get new_book_url
    assert_response :success
  end
  
  test "should show book" do
    get book_url(@book)
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post books_url, params: { book: { title: 'Ruby for Toddlers', publisher_id: 2, published_at: Time.now,
                                        authors: [{ first_name:"Joel",last_name:"Spolsky" }], isbn: "123-123-123-1", 
                                        blurb: 'The best book since "Bodo Bär zu Hause"', 
                                        page_count: 12, price: 40.4} }
    end
    #assert_response :success
    assert_redirected_to book_url(Book.last)
  end
  test "should get edit" do
    get edit_book_path(Book.first)
    #assert_response :success
    #get edit_author_path(Author.first)
    #assert_select 'input', :attributes => { :name => 'author[first_name]', :value => 'Joel' }
  end

  test "should update book" do
    patch book_url(@book), params: { book: { title: 'Ruby for Toddlers', publisher_id: 2, published_at: Time.now,
                                              authors: [{ first_name:"Joel",last_name:"Spolsky" }], isbn: "123-123-123-1", 
                                              blurb: 'The best book since "Bodo Bär zu Hause"', 
                                              page_count: 12, price: 40.4} }
    assert_redirected_to book_url(@book)
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end

  #def params
    # strong parameters
  #  params.require(:book).permit(:title, :publisher_id, :published_at, :authors, :isbn, :blurb, :page_count, :price)
  #end

end
