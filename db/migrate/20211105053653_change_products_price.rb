class ChangeProductsPrice < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      change_table :products do |t|
        dir.up   { t.change :price, :float }
        dir.down { t.change :price, :integer }
      end
    end
  end
end
