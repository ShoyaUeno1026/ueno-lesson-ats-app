class Announcement < ApplicationRecord
  KINDS = %w[new fix update]
  
  validates :kind, :published_at, :title, :description, presence: true
  validates :kind, inclusion: {in: KINDS}

  attribute :published_at, default: -> { Time.current}
end
