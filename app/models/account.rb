class Account < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :account_users, dependent: :destroy
  has_many :users, through: :account_users
  has_many :departments, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :job_pipelines, dependent: :destroy
  has_many :job_pipeline_stages, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true

  after_create :create_default_job_pipeline

  def create_default_job_pipeline
    return job_pipelines.default.first if job_pipelines.default.any?

    job_pipeline = job_pipelines.new(name: "Default", is_default: true)
    job_pipeline.save!
    job_pipeline
  end
end
