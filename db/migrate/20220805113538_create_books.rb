class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false, limit: 255
      t.integer :publisher_id, null: false
      t.datetime :published_at
      t.string :isbn, limit: 13, unique: true
      t.text :blurb
      t.integer :page_count
      t.integer :price

      t.timestamps
    end
  end
end
