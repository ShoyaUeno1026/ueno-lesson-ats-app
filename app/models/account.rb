class Account < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :account_users, dependent: :destroy
  has_many :users, through: :account_users
  has_many :departments, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
end
