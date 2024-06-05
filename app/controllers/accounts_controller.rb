class AccountsController < Accounts::BaseController
  before_action :set_account, only: %i[show edit update destroy switch]
  before_action :require_account_admin, only: %i[edit update destroy]

  def index
    @accounts = current_user.accounts.order(:created_at)
  end

  def show
  end

  def new
    @account = Account.new
  end

  def edit
  end

  def create
    @account = Account.new(account_params)
    @account.owner = current_user
    @account.account_users.new(user: current_user, roles: "admin")

    if @account.save
      flash[:notice] = t(".created")
      switch
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @account.update(account_params)
      redirect_to account_url(@account), notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @account.destroy!

    redirect_to accounts_url, notice: t(".destroyed")
  end

  def switch
    session[:account_id] = @account.id
    redirect_to root_path
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  def account_params
    params.require(:account)
      .permit(:name, :image, :account_type)
  end
end
