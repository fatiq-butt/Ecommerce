class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :name, null: false
      t.float :discount, null: false

      t.timestamps
    end
  end
end
