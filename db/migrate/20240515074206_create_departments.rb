class CreateDepartments < ActiveRecord::Migration[7.1]
  def change
    create_table :departments do |t|
      t.bigint "account_id", null: false
      t.bigint "owner_id"
      t.string "name"
      t.integer "jobs_count", default: 0
      t.string "industry"
      t.string "location"
      t.string "website"

      t.timestamps
    end
  end
end
