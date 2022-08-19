class DropTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :books_and_authors_books
    drop_table :authors_books_add_details
  end
end
