class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :manufacturer, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.boolean :used, null: false
      t.string :note
      t.timestamps
    end
  end
end
