class AddCouponToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :coupon, null: true, foreign_key: true
    add_column :orders, :total_price, :float
    add_column :orders, :discounted_total, :float
    add_column :orders, :confirmed, :boolean, default: false
    add_column :orders, :payment_method, :string
  end
end
