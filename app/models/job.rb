class Job < ApplicationRecord
  include Ownership

  CONTRACTS = %w[full_time part_time intern]
  CURRENCIES = %w[¥ $]
  FREQUENCIES = %w[month day year]
  VISIBILITIES = %w[private public archive]

  belongs_to :account
  belongs_to :department, counter_cache: true, optional: true
  belongs_to :job_pipeline, optional: true
  has_many :matches, dependent: :destroy
  has_many :candidates, through: :matches
  has_many :match_histories, dependent: :destroy
  
  has_rich_text :description

  attribute :visibility, default: -> { "private" }

  validates :department_id, presence: true
  validates :job_pipeline_id, presence: true
  validates :position_name, presence: true
  validates :contract, inclusion: {in: CONTRACTS}, allow_blank: true
  validates :currency, inclusion: {in: CURRENCIES}, allow_blank: true
  validates :frequency, inclusion: {in: FREQUENCIES}, allow_blank: true
  validates :salary_max, comparison: {greater_than_or_equal_to: :salary_min}, allow_blank: true
  validates :visibility, inclusion: {in: VISIBILITIES}

  def matches_on_stage(stage:)
    matches.where(job_pipeline_stage: stage).list
  end

  def dropped_matches_on_stage(stage:)
    matches.where(job_pipeline_stage: stage).dropped
  end

  def salary_to_text
    min = salary_min.presence || "***"
    max = salary_max.presence || "***"
    [min, max].join(" - ") + frequency
  end

  def job_pipeline_stages
    job_pipeline&.stages&.list
  end
end
