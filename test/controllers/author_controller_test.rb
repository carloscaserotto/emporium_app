require "test_helper"

class AuthorControllerTest < ActionDispatch::IntegrationTest
  fixtures :authors

  

  test "should get index" do
    get author_index_path  
    assert_response :success
    #assert_select 'table', :children => {:count => Author.count + 1,
    #                                      :only => {:tag => 'tr'}
  end 

  test "should get new" do
    get new_author_path
    assert_response :success
  end

  def test_new
    get new_author_path
    assert_template 'author/new'
    assert_select 'h1', 'Create new author'
    assert_select 'form', :attributes => {:action => '/author/create'}
    #assert_tag no se usa mas en Rails 6
    #assert_tag 'h1', :content => 'Create new author'
    #assert_tag 'form', :attributes => {:action => '/admin/author/create'}
  end
  test "should get create" do
    #get new_admin_author_path
    get new_author_path
    assert_response :success
    #assert_template '/author/new'
    assert_difference 'Author.count' do
      post "/author", params: { author: { first_name:"Joel",last_name:"Spolsky" } }
    end
    #assert_redirected_to '/author/4'
    assert_response :redirect
    assert_equal 'Author Joel Spolsky was successfully created.', flash[:notice]
    #assert_difference 'Author.count' do
    # author = Author.create(first_name:"Joel",last_name:"Spolsky")
    #end
  end
  
  def test_failing_create
    assert_no_difference 'Author.count' do
      post "/author", params: { author: { first_name:"Joel" } }
      assert_response :success
      #assert_template '/author/new'
      assert_select 'div', :attributes => {:class => 'fieldWithErrors'}
    end
  end
  
  def test_show
    #get :show, :id => 1
    #get "/admin/author/new"
    get author_path(Author.first)
    assert_template 'author/show'
    assert_equal 'Joel', Author.first.first_name
    assert_equal 'Spolsky', Author.first.last_name
    #assert_equal 'Joel', assigns(:author).first_name
    #assert_equal 'Spolsky', assigns(:author).last_name
  end

  def test_edit
    #get :edit, :id => 1
    get edit_author_path(Author.first)
    assert_select 'input', :attributes => { :name => 'author[first_name]', :value => 'Joel' }
    #assert_tag :tag => 'input', :attributes => { :name => 'author[first_name]', :value => 'Joel' }
    #assert_tag :tag => 'input', :attributes => { :name => 'author[last_name]',  :value => 'Spolsky' }
  end

  def test_update
    #post :update, :id => 1, :author => { :first_name => 'Joseph', :last_name => 'Spolsky' }
    patch author_path(Author.first), params: { author: { first_name:"Joseph",last_name:"Spolsky" } }
    assert_response :redirect
    assert_redirected_to author_path(Author.first)
    assert_equal 'Joseph', Author.find(1).first_name
  end

  def test_destroy
    assert_difference("Author.count", -1) do
      #post :destroy, :id => 1
      delete author_path(Author.first)
      assert_response :redirect
      assert_redirected_to :action => 'index'
      #follow_redirect
      #assert_tag :tag => 'div', :attributes => {:id => 'notice'}, :content => 'Successfully deleted author Joel Spolsky'
      #assert_select 'div', :attributes => {:id => 'notice'}, :content => 'Successfully deleted author Joel Spolsky'
    end
  end


  #def test_create
    #post admin_author_create_url
    #assert_equal 0, Author.all.size
    #assert_difference 'Author.count' do
    # author = Author.create(first_name:"Joel",last_name:"Spolsky")
    #end
    #assert_response :redirect
    #assert_redirected_to :action => admin_author_index_url
    #get admin_author_new_url
    #assert_template 'admin/author/new'
    #assert_difference(Author, :count) do
    #  post :create, :author => {:first_name => 'Joel',:last_name => 'Spolsky'}
    #assert_difference 'Author.count' do
    #  post :create, params: { author: {:first_name => 'Joel',:last_name => 'Spolsky'} }
    #end
    #assert_equal 'Author Joel Spolsky was successfully created.', flash[:notice]
  #end

=begin  
  
  test "should get new" do
    get admin_author_new_url
    assert_response :success
  end
  
  test "should get create" do
    get admin_author_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_author_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_author_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_author_destroy_url
    assert_response :success
  end

  test "should get show" do
    get admin_author_show_url
    assert_response :success
  end

  test "should get index" do
    get admin_author_index_url
    assert_response :success
  end
=end
end
