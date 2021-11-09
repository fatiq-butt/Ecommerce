class CreateCouponsAndProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons_products do |t|
      t.belongs_to :coupon
      t.belongs_to :product
  
      t.timestamps
    end
  end
end
