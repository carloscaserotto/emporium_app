class CreatePubleshers < ActiveRecord::Migration[6.1]
  def change
    create_table :publeshers do |t|
      t.string :publesher

      t.timestamps
    end
  end
end
