class AddColumnAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :account_type, :string
  end
end
