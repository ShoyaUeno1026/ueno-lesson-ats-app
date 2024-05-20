class JobPipeline < ApplicationRecord
  belongs_to :account
  has_many :stages, class_name: "JobPipelineStage", dependent: :destroy
  has_many :jobs, dependent: :nullify

  validates :name, presence: true

  after_create :create_default_stages

  scope :default, -> { where(is_default: true) }

  def create_default_stages
    return stages if stages.any?

    JobPipelineStage::KINDS.each do |kind|
      stages.create!(
        account: account,
        name: I18n.t("accounts.job_pipelines.job_pipeline_stages.kinds.#{kind}"),
        kind: kind,
        is_protected: true
      )
    end
  end

  def first_stage
    stages.list.first
  end
end
