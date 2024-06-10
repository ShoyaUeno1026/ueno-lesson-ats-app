class Accounts::AccountUsersController < Accounts::BaseController
  before_action :authenticate_user!
  before_action :set_account
  before_action :set_users, only: %i[new create]
  before_action :set_account_user, only: [:edit, :update, :destroy]
  before_action :require_account_admin, except: [:index, :show]


  def index
    redirect_to @account
  end

  def show
    redirect_to @account
  end
  
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

  def edit
  end

  def update
    if @account_user.update(account_user_params)
      redirect_to @account, notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @account_user.destroy
    redirect_to @account, status: :see_other, notice: t(".destroyed")
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def set_users
    @users = User.where.not(id: @account.users.pluck(:id))
  end

  def set_account_user
    @account_user = @account.account_users.find(params[:id])
  end

  def account_user_params
    params.require(:account_user).permit(*AccountUser::ROLES)
  end
end
