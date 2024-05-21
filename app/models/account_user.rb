class AccountUser < ApplicationRecord
  ROLES = %w[admin member]

  belongs_to :account
  belongs_to :user

  def account_owner?
    account.owner_id == user_id
  end

  def admin?
    role == "admin"
  end
end
