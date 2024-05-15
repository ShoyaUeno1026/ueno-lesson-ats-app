class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.bigint "owner_id", null: false
      t.string "name"
      
      t.timestamps
    end
  end
end
