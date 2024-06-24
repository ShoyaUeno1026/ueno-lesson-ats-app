class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.belongs_to :account, null: false
      t.belongs_to :department
      t.belongs_to :job_pipeline
      t.belongs_to :owner
      t.belongs_to :job
      t.string :position_name
      t.integer :headcount
      t.string :contract
      t.integer :salary_min
      t.integer :salary_max
      t.string :currency
      t.string :frequency
      t.string :location
      t.boolean :is_remote, null:false, default: false
      t.string :visilibity
      t.integer :matches_count, default: 0
      
      t.timestamps
    end
  end
end
