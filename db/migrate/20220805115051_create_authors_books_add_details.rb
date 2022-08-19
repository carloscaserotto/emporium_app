class CreateAuthorsBooksAddDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :authors_books_add_details do |t|
      add_column :authors_books, :author_id, :integer
      add_column :authors_books, :book_id, :integer


      t.timestamps
    end
  end
 
end
