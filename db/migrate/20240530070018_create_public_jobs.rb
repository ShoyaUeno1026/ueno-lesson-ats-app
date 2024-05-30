class CreatePublicJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :public_jobs do |t|
      t.belongs_to :account, null: false
      t.belongs_to :job
      t.belongs_to :department
      t.belongs_to :owner

      t.timestamps
    end
  end
end
