class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :company_name, :string
    add_column :users, :state, :string
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :extension, :integer
    add_column :users, :city, :string
    add_column :users, :zip_code, :string
    add_column :users, :country, :string
  end
end
