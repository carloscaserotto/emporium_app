class CreateAuthorsBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :authors_books do |t|

      t.timestamps
    end
  end
end
