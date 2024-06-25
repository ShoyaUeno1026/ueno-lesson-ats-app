class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.belongs_to :account, null:false
      t.belongs_to :user, null: false
      t.text :state
      t.text :task
      t.date :limit_date

      t.timestamps
    end
  end
end
