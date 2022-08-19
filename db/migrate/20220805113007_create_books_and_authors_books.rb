class CreateBooksAndAuthorsBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books_and_authors_books do |t|

      t.timestamps
    end
  end
end
