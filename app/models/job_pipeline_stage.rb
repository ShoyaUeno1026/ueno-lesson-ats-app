class JobPipelineStage < ApplicationRecord
  KINDS = %w[pending processing processed]

  belongs_to :account
  belongs_to :job_pipeline

  validates :kind, :name, presence: true
  validates :kind, inclusion: {in: KINDS}

  scope :list, -> { order(:display_order) }

  def pending?
    kind == "pending"
  end

  def processing?
    kind == "processing"
  end

  def processed?
    kind == "processed"
  end

  def deletable?
    !is_protected
  end

  def kind_editable?
    !is_protected
  end
end
