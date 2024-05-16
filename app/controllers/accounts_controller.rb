class AccountsController < Accounts::BaseController
  before_action :set_account, only: %i[show]

  def index
    @accounts = current_user.accounts.order(:created_at)
  end

  def show
  end

  def edit
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
