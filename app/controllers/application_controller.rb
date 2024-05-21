class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_request_details

  helper_method :current_account, :current_account_user, :current_account_admin?

  def current_account
    @_current_account
  end

  def current_account_user
    @_account_user ||= current_account.account_users.find_by(user: current_user)
  end

  def current_account_admin?
    !!current_account_user&.admin?
  end

  def set_request_details
    @_current_account ||= account_from_session || fallback_account
  end

  def account_from_session
    return unless user_signed_in?
    current_user.accounts.find_by(id: session[:account_id])
  end

  def fallback_account
    return unless user_signed_in?
    current_user.accounts.order(created_at: :asc).first || current_user.create_default_account
  end

  protected

  def configure_permitted_parameters
    extra_keys = [:image, :name]
    signup_keys = extra_keys + [:terms_of_service]
    devise_parameter_sanitizer.permit(:sign_up, keys: signup_keys)
    devise_parameter_sanitizer.permit(:account_update, keys: extra_keys)
  end
end
