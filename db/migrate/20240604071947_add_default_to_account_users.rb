class AddDefaultToAccountUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :account_users, :role, {}

    change_column_null :account_users, :role, false
  end
end
