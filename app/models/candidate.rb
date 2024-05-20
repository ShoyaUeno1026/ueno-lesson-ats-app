class Candidate < ApplicationRecord
  include Ownership

  GENDERS = %w[man woman unknown]
  SOURCE_TYPES = %w[form recruiter referral others]

  belongs_to :account
  has_many :jobs, through: :matches

  has_person_name

  has_one_attached :image

  validates :name, presence: true
  validates :email, format: {with: Devise.email_regexp}, allow_blank: true
  validates :gender, inclusion: {in: GENDERS}, allow_blank: true
  validates :source_type, inclusion: {in: SOURCE_TYPES}, allow_blank: true

end
