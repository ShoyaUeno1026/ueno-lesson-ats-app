class CreateCandidates < ActiveRecord::Migration[7.1]
  def change
    create_table :candidates do |t|
      t.belongs_to :account
      t.belongs_to :owner
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :gender
      t.date :birth_date
      t.string :location
      t.string :source_type
      t.boolean :is_employee, null: false, default: false
      t.jsonb :custom_fields, default: {}, null: false

      t.timestamps
    end
  end
end
