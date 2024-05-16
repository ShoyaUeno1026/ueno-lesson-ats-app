class AccountUser < ApplicationRecord
  ROLES = %w[admin member]

  belongs_to :account
  belongs_to :user

  def admin?
    role == "admin"
  end
end
