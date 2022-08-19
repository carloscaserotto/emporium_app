class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.integer :book_id
      t.integer :cart_id
      t.integer :price
      t.integer :amount

      t.timestamps
    end
  end
end
