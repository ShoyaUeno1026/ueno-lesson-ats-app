module AccountsHelper
  def account_user_roles(account, account_user)
    roles = []
    roles << I18n.t("account_user_roles.owner") if account_user.respond_to?(:user_id) && account.owner_id == account_user.user_id
    AccountUser::ROLES.each do |role|
      roles << I18n.t("account_user_roles.#{role}") if account_user.public_send(:"#{role}?")
    end
    roles
  end
end