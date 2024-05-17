class AccountsController < Accounts::BaseController
  before_action :set_account, only: %i[show edit update destroy]
  before_action :require_account_admin, only: %i[edit update destroy]

  def index
    @accounts = current_user.accounts.order(:created_at)
  end

  def show
  end

  def edit
  end

  def update
    if @account.update(account_params)
      redirect_to account_url(@account), notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  def account_params
    params.require(:account)
      .permit(:name, :image)
  end
end
