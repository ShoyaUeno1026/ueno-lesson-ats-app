# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def build_resource(hash = {})
    self.resource = resource_class.new_with_session(hash, session)

    # Registering to accept an invitation should display the invitation on sign up
    if params[:invite] && (invite = AccountInvitation.find_by(token: params[:invite]))
      @account_invitation = invite
      resource.skip_default_account = true
      # Skip email confirmation on invitation
      resource.skip_confirmation!

    # Build and display account fields in registration form
    else
      account = resource.owned_accounts.first
      account ||= resource.owned_accounts.new
      account.account_users.new(user: resource, admin: true)
    end
  end

  #必須  更新（編集の反映）時にパスワード入力を省く
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)

    # If user registered through an invitation, automatically accept it after signing in
    if @account_invitation
      @account_invitation.accept!(current_user)

      # Clear redirect to account invitation since it's already been accepted
      stored_location_for(:user)
    end
  end
end
