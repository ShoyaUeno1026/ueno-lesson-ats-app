class Accounts::AccountUsersController < Accounts::BaseController
  before_action :set_account
  before_action :set_users, only: %i[new create]

  def new
    @account_user = AccountUser.new
    
    return unless params[:account_id]

    flash.now[:notice] = t(".new_from_account", name: @account.name)
  end

  def create
    @account_user = AccountUser.new(account_user_params)
    @account_user.account = @account

    if @account_user.save
      redirect_to account_url(@account), notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def set_users
    @users = User.where.not(id: @account.users.pluck(:id))
  end

  def account_user_params
    params.require(:account_user)
      .permit(:user_id, :role)
  end
end
