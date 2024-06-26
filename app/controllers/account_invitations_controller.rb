class AccountInvitationsController < ApplicationController
  before_action :set_account_invitation
  before_action :authenticate_user_with_invite!, except: [:destroy]

  def show
    @account = @account_invitation.account
    @invited_by = @account_invitation.invited_by
  end

  def destroy
    @account_invitation.destroy
    redirect_to root_path, status: :see_other, notice: t("refused")
  end

  private

  def set_account_invitation
    @account_invitation = AccountInvitation.find_by!(token: params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: t(".not_found")
  end

  def authenticate_user_with_invite!
    if user_signed_in?
      @account_invitation.accept!(current_user)
      stored_location_for(:user)
      redirect_to root_path
    else
      store_location_for(:user, request.fullpath)
      redirect_to new_user_registration_path(invite: @account_invitation.token), alert: t(".authenticate")
    end
  end
end
