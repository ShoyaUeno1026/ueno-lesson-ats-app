module User::Accounts
  extend ActiveSupport::Concern

  included do
    has_many :account_users, dependent: :destroy
    has_many :accounts, through: :account_users
    has_many :owned_accounts, class_name: "Account", foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy

    after_create :create_default_account, unless: :skip_default_account?

    accepts_nested_attributes_for :owned_accounts, reject_if: :all_blank
    
    # Used for skipping a default account on create
    attribute :skip_default_account, :boolean, default: false
  end

  def create_default_account
    return accounts.first if accounts.any?

    account = accounts.new(owner: self, name: name)
    account.account_users.new(user: self, admin: true)
    account.save!
    account
  end
end
