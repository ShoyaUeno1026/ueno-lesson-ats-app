class AccountUser < ApplicationRecord
  ROLES = [:admin, :member]

  include Rolified

  belongs_to :account
  belongs_to :user

  validates :user_id, uniqueness: {scope: :account_id}
  validate :owner_must_be_admin, on: :update, if: -> { admin_changed? && account_owner? }

  def account_owner?
    account.owner_id == user_id
  end

  def owner_must_be_admin
    unless admin?
      errors.add :admin, :cannot_be_changed
    end
  end
end
