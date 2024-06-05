class ChangeColumnRoleOfAccountUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :account_users, :role, 'jsonb USING CAST(role AS jsonb)'
  end
end
