class Match < ApplicationRecord
  DROP_REASONS = ["社風に合わない", "条件に合わない", "応答なし", "充足", "その他"]

  belongs_to :account
  belongs_to :job, counter_cache: true
  belongs_to :candidate
  belongs_to :job_pipeline_stage, optional: true

  validates :candidate_id, uniqueness: {scope: :job_id}

  after_create :set_first_stage

  scope :active, -> { where(dropped_at: nil) }
  scope :dropped, -> { where.not(dropped_at: nil) }
  scope :list, -> { active.order(:display_order) }

  def set_first_stage
    self.job_pipeline_stage = job.job_pipeline.first_stage
    save!
  end

  def selectable_stages
    job_pipeline_stage.job_pipeline.stages.list
  end
end
