class RenameRoleColumnToRoles < ActiveRecord::Migration[7.1]
  def change
    rename_column :account_users, :role, :roles
  end
end
