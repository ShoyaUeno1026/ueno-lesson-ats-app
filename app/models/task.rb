class Task < ApplicationRecord
  STATES = %w[todo doing done]

  belongs_to :account
  belongs_to :user

  validates :state, presence: true
  validates :limit_date, presence: true
  validates :content, presence: true
end
