class Accounts::MatchHistoriesController < Accounts::BaseController
  before_action :set_account

  def index
    @match_histories = @account.match_histories.all
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def set_match
    @match = @account.matches.find(params[:id])
  end
end
