class AccountInvitationsMailer < ApplicationMailer
  def invite
    @account_invitation = params[:account_invitation]
    @account = @account_invitation.account
    @invited_by = @account_invitation.invited_by

    mail(
      to: email_address_with_name(@account_invitation.email, @account_invitation.name),
      from: email_address_with_name(Rails.configuration.shiraha.support_email, @invited_by.name),
      subject: t(".subject", inviter: @invited_by.name, account: @account.name)
    )
  end
end
