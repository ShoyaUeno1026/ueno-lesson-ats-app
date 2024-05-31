class AccountUser < ApplicationRecord
  ROLES = %w[admin member]

  belongs_to :account
  belongs_to :user

  validates :role, inclusion: {in: ROLES}
  validates :user_id, uniqueness: {scope: :account_id}
  validate :owner_must_be_admin, on: :update, if: -> { role_changed? && account_owner? }

  def account_owner?
    account.owner_id == user_id
  end

  def admin?
    role == "admin"
  end

  def member?
    role == "member"
  end

  def owner_must_be_admin
    unless admin?
      errors.add :role, :cannot_be_changed
    end
  end
end
