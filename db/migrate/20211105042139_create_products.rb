class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.integer :price, null: false
      t.string :description, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
