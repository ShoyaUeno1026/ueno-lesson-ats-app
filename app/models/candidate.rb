class Candidate < ApplicationRecord
  include Ownership

  GENDERS = %w[man woman unknown]
  SOURCE_TYPES = %w[form entry recruiter referral others]

  belongs_to :account
  has_many :matches, dependent: :destroy
  has_many :jobs, through: :matches
  has_many :match_histories, dependent: :destroy

  has_person_name

  has_one_attached :image

  validates :name, presence: true
  validates :email, format: {with: Devise.email_regexp}, allow_blank: true
  validates :gender, inclusion: {in: GENDERS}, allow_blank: true
  validates :source_type, inclusion: {in: SOURCE_TYPES}, allow_blank: true

  attr_accessor :from_public_job  # 仮想的な属性の定義

  after_save :create_match, if: :from_public_job?

  private
  # create_from_public_job でのみ選考を作成する条件を定義
  def from_public_job?
    from_public_job.present? && from_public_job
  end

  # 選考を作成するメソッド
  def create_match
    account = Account.find_by(id: self.account_id)
    
    if account.present?
      match = Match.new(
        account: account,
        user: account.owner,
        job: account.jobs.find(self.job_id),
        candidate: self
      )

      if match.save
        # 選考作成後の追加の処理（例えば、履歴の作成など）
        create_history_for_match(match)
      else
        # 選考作成に失敗した場合のエラーハンドリング
        errors.add(:base, "Match creation failed")
        raise ActiveRecord::Rollback
      end
    else
      # アカウントが見つからない場合のエラーハンドリング
      errors.add(:base, "Account not found")
      raise ActiveRecord::Rollback
    end
  end

  # 選考に関連する履歴を作成するメソッド
  def create_history_for_match(match)
    history = match.match_histories.build(
      account_id: match.account.id,
      match_id: match.id,
      job_id: match.job.id,
      candidate_id: match.candidate.id,
      job_pipeline_stage_id: match.job_pipeline_stage.id,
      pending_at: match.pending_at,
      processing_at: match.processing_at,
      processed_at: match.processed_at,
      dropped_at: match.dropped_at,
      drop_reasons: match.drop_reasons,
      display_order: match.display_order,
      user_id: match.job.owner.id
    )

    history.save
  end
end
