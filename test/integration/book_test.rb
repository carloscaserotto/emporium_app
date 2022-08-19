require "test_helper"

class BookTest < ActionDispatch::IntegrationTest
  fixtures :publishers, :authors

  setup do
    @book = books(:libro1)
  end
  # test "the truth" do
  #   assert true
  # end

  def test_book_administration
    publisher = Publisher.create(publisher:'Books for Dummies')
    author = Author.create(first_name: 'Bodo', last_name: 'Bar')
    #george = new_session_as(:george)
    #ruby_for_dummies = george.add_book() 
    get books_url
    assert_response :success
    get '/books/new'
    assert_response :success
    assert_select 'option', :attributes => { :value => publisher.id }
    assert_select 'select', :attributes => { :id => 'book[author_ids][]'}
    #post "/author", params: { author: { first_name:"Joel",last_name:"Spolsky" } }
    post books_url, params: { book: { title: 'Ruby for Toddlers', publisher_id: 2, published_at: Time.now, 
                                      authors: Author.all, 
                                      isbn: "123-123-123-1", blurb: 'The best book since "Bodo Bär zu Hause"', 
                                      page_count: 12, price: 40.4} }
    
    
      assert_response :redirect
      #follow_redirect!
      #get '/books/4'
      #assert_select 'p'
      #assert_tag :tag => 'td', :content => parameters[:book][:title]
      #george.list_books
      #george.show_book ruby_for_dummies
      
    
  end

  test 'show_book' do
    get "/books/#{@book.id}"
    assert_response :success
    assert_template "books/show"
  end
  test "should get edit" do
    get edit_book_path(@book)
    assert_response :success
  end

  test 'edit_book' do
    get "/books/#{@book.id}/edit/"
    assert_response :success
    #assert_template '"books/_form", "books/edit", "layouts/application"'
    patch book_url(@book), params: { book: { title: 'Ruby for Toddlers', publisher_id: 2, published_at: Time.now,
                                                        authors: [{ first_name:"Joel",last_name:"Spolsky" }], isbn: "123-123-123-1", 
                                                        blurb: 'The best book since "Bodo Bär zu Hause"', 
                                                        page_count: 12, price: 40.4} }
    #post "/admin/book/update/#{book.id}", parameters
    assert_response :redirect
    follow_redirect!
    assert_response :success
    #assert_template "/books/show"
  end

  test 'delete_book' do
    delete "/books/#{@book.id}"
    assert_response :redirect
    follow_redirect!
    #assert_template "/books"
  end
  
  test 'test_ferret' do
    Book.rebuild_index
    assert Book.find_by(title: "Pride and Prejudice")
    assert_difference 'Book.count' do
      #post books_url, params: { book: { title: 'The Success of Open Source', publisher_id: 2, published_at: Time.now,
      #                                     authors: [{ first_name:"Joel",last_name:"Spolsky" }], isbn: "0-674-01292-5", 
      #                                      blurb: 'The best book since', 
      #                                      page_count: 500, price: 59.99} }
      book = Book.new(title: 'The Success of Open Source', publisher_id: 2, published_at: Time.now,
                      isbn: "0-674-01292-5", 
                      blurb: 'The best book since', 
                      page_count: 500, price: 59.99)
      book.authors << Author.create(first_name: "Steven", last_name: "Weber")
      book.publisher = Publisher.find(1)
      assert book.valid?
      book.save
      assert_equal 26, Book.find_by(title: "The Success of Open Source").title.size
      assert_equal 1, Author.where("first_name like ?", "%Steven%").size
    end
       
  end
  
 
=begin
  def edit_book(book, parameters)
      get "/admin/book/edit/#{book.id}"
      assert_response :success
      assert_template "admin/book/edit"
      post "/admin/book/update/#{book.id}", parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template "admin/book/show"
  end
  def test_book_administration
    ruby_for_dummies = george.add_book :params => {
      :title => 'Ruby for Dummies',
      :publisher_id => publisher.id,
      :author_ids => [author.id],
      :published_at => Time.now,
      :isbn => '123-123-123-X',
      :blurb => 'The best book released since "Eating for Dummies"',
      :page_count => 123,
      :price => 40.4
    }
    

    book = Book.new(
      :title => 'Ruby for Toddlers',
      :publisher_id => Publisher.find(1).id,
      :published_at => Time.now,
      :authors => Author.all,
      :isbn => '123-123-123-1',
      :blurb => 'The best book since "Bodo Bär zu Hause"',
      :page_count => 12,
      :price => 40.4
    )
    assert book.save

    params: { book: {
      :title => 'Ruby for Toddlers',
      :publisher_id => Publisher.find(1).id,
      :published_at => Time.now,
      :authors => Author.all,
      :isbn => '123-123-123-1',
      :blurb => 'The best book since "Bodo Bär zu Hause"',
      :page_count => 12,
      :price => 40.4
      } }

    

  end

  private
  module BookTestDSL
    attr_writer :name
  
    def add_book()
      post "/books", params 
      #post books_url, params: { book: {  } }
      #assert_response :redirect
      #follow_redirect!
      assert_response :success
      #assert_template "book/list"
      assert_template "books"
      #assert_tag :tag => 'td', :content => parameters[:book][:title]
      return Book.find_by(title: parameters[:book][:title])
    end
  end
  
  def new_session_as(name)
    open_session do |session|
      session.extend(BookTestDSL)
      session.name = name
      yield session if block_given?
      end
  end
=end  
end
