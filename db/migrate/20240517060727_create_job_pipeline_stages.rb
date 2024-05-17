class CreateJobPipelineStages < ActiveRecord::Migration[7.1]
  def change
    create_table :job_pipeline_stages do |t|
      t.belongs_to :account, null: false
      t.belongs_to :job_pipeline, null: false
      t.string :name
      t.string :kind
      t.integer :display_order
      t.boolean :is_protected, null: false, default: false

      t.timestamps
    end
  end
end
