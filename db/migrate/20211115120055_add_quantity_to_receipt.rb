class AddQuantityToReceipt < ActiveRecord::Migration[6.1]
  def change
    add_column :receipts, :quantity, :integer
  end
end
