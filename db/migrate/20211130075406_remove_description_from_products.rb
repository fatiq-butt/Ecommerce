class RemoveDescriptionFromProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :description, :string
  end
end
