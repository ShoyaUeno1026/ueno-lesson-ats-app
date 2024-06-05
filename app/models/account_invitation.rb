class AccountInvitation < ApplicationRecord
  ROLES = AccountUser::ROLES

  include Rolified

  belongs_to :account
  belongs_to :invited_by, class_name: "User", optional: true
  has_secure_token

  validates :name, :email, presence: true
  validates :email, uniqueness: {scope: :account_id, message: :invited}

  def save_and_send_invite
    save && send_invite
  end

  def send_invite
    AccountInvitationsMailer.with(account_invitation: self).invite.deliver_later
  end

  
end
