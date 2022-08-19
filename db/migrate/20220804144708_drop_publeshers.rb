class DropPubleshers < ActiveRecord::Migration[6.1]
  def change
    drop_table :publeshers
  end
end
