class CreateAccountUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :account_users do |t|
      t.bigint "account_id", null: false
      t.bigint "user_id", null: false
      t.string "role"
      
      t.timestamps
    end
  end
end
