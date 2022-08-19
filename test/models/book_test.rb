require "test_helper"

class BookTest < ActiveSupport::TestCase
  fixtures :publishers, :authors, :books, :authors_books

  setup do
    @libro = books(:libro1)
  end
  # test "the truth" do
  #   assert true
  # end
  def test_failing_create
    book = Book.new
    assert_equal false, book.save
    assert_equal 7, book.errors.size
    assert book.errors[:title]
    assert book.errors[:publisher]
    assert book.errors[:authors]
    assert book.errors[:published_at]
    assert book.errors[:isbn]
    assert book.errors[:page_count]
    assert book.errors[:price]
  end
  def test_create
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
  end
  #hay que arreglar este test-llegue hasta aca pag 84 (106 en pdf)
  def test_has_many_and_belongs_to_mapping
    apress = Publisher.find_by(publisher: "Apress")
    assert_equal 1, apress.books.size
    book = Book.new(
      :title => 'Rails E-Commerce 3nd Edition',
      :authors => [Author.find_by(first_name: 'Joel'),
                   Author.find_by(first_name: 'Jeremy')],
      :published_at => Time.now,
      :isbn => '123-123-123-x',
      :blurb => 'E-Commerce on Rails',
      :page_count => 300,
      :price => 30.5
    )
    apress.books << book
    apress.reload
    book.reload
    assert_equal 2, apress.books.size
    assert_equal 'Apress', book.publisher.publisher
  end

  def test_has_and_belongs_to_many_authors_mapping
    book = Book.new(
      :title => 'Rails E-Commerce 3nd Edition',
      :publisher => Publisher.find_by(publisher: "Apress"),
      :authors => [Author.find_by(first_name: 'Joel'),
                   Author.find_by(first_name: 'Jeremy')],
      :published_at => Time.now,
      :isbn => '123-123-123-x',
      :blurb => 'E-Commerce on Rails',
      :page_count => 300,
      :price => 30.5
    )
    assert book.save
    book.reload
    assert_equal 2, book.authors.size
    assert_equal 2, Author.find_by(first_name: 'Joel').books.size
    end
end
