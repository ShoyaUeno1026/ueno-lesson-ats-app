class MatchHistory < ApplicationRecord

  belongs_to :account
  belongs_to :user
  belongs_to :match
  belongs_to :job
  belongs_to :candidate
  belongs_to :job_pipeline_stage, optional: true

end
