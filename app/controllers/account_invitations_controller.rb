class AccountInvitationsController < ApplicationController
  before_action :set_account_invitation
  before_action :authenticate_user_with_invite!

  def show
    @account = @account_invitation.account
    @invited_by = @account_invitation.invited_by

    if user_signed_in?
      @account_invitation.accept!(current_user)
      stored_location_for(:user)
      redirect_to root_path
    end
  end

  private

  def set_account_invitation
    @account_invitation = AccountInvitation.find_by!(token: params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: t(".not_found")
  end

  def authenticate_user_with_invite!
    unless user_signed_in?
      store_location_for(:user, request.fullpath)
      redirect_to new_user_registration_path(invite: @account_invitation.token), alert: t(".authenticate")
    end
  end
end
