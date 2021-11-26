class AddInvitedUserToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :invited_user, :boolean, default: false
  end
end
