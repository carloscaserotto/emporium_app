require "test_helper"

class AuthorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #test name
  def test_name
    author = Author.create(:first_name => 'Joel', :last_name => 'Spolsky')
    assert_equal 'Joel Spolsky', author.name
    end
end
