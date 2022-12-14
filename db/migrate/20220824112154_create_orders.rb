class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      # Contact Information
      t.string :email
      t.string :phone_number
      # Shipping Address
      t.string :ship_to_first_name
      t.string :ship_to_last_name
      t.string :ship_to_address
      t.string :ship_to_city
      t.string :ship_to_postal_code
      t.string :ship_to_country
      # Private parts
      t.string :customer_ip
      t.string :status
      t.string :error_message
      

      t.timestamps
    end
  end
end
