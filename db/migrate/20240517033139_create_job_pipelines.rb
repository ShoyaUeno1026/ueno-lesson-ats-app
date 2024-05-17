class CreateJobPipelines < ActiveRecord::Migration[7.1]
  def change
    create_table :job_pipelines do |t|
      t.belongs_to :account, null: false
      t.string :name
      t.boolean :is_default, null: false, default: false
      t.timestamps
    end
  end
end
