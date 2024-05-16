class Department < ApplicationRecord
  include Ownership

  belongs_to :account

  has_rich_text :description

  validates :name, presence: true
end
