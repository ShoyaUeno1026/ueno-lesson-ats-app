class Department < ApplicationRecord
  include Ownership

  belongs_to :account
  has_many :jobs, dependent: :destroy

  has_rich_text :description

  validates :name, presence: true
  validates :website, format: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, allow_blank: true
end
