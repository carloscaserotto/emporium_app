class DropPublishers < ActiveRecord::Migration[6.1]
  def change
    drop_table :publishers
  end
end
