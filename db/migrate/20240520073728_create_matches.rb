class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.belongs_to :account, null: false
      t.belongs_to :job, null: false
      t.belongs_to :candidate, null: false
      t.belongs_to :job_pipeline_stage
      t.datetime :pending_at
      t.datetime :processing_at
      t.datetime :processed_at
      t.datetime :dropped_at
      t.string :drop_reasons, array: true, default: []
      t.integer :display_order

      t.timestamps
    end
  end
end
